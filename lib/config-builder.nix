{ lib }:

let
  shouldBeExecutable = filePath: executableList:
    let
      fileName = builtins.baseNameOf filePath;
      relativePath = filePath;
    in
      builtins.any (pattern:
        if lib.isString pattern then
          lib.hasSuffix pattern filePath || 
          pattern == fileName ||
          pattern == relativePath
        else if lib.isList pattern then
          let regex = builtins.head pattern; in
          builtins.match regex filePath != null
        else
          false
      ) executableList;

  processDirectory = dir: targetBase: cfg:
    let
      contents = builtins.readDir dir;
      
      shouldInclude = filePath: relativePath:
        if cfg.include != [] then
          builtins.any (pattern:
            lib.hasSuffix pattern filePath ||
            lib.hasSuffix pattern relativePath ||
            lib.hasSuffix pattern (builtins.baseNameOf filePath)
          ) cfg.include
        else
          !(builtins.any (pattern:
            lib.hasSuffix pattern filePath ||
            lib.hasSuffix pattern relativePath ||
            lib.hasSuffix pattern (builtins.baseNameOf filePath)
          ) cfg.exclude);
      
      processEntry = name: type:
        let
          fullPath = dir + "/${name}";
          targetPath = targetBase + "/${name}";
          relativeFromRoot = if cfg.target == cfg.name then
              "${cfg.name}/${name}"
            else
              "${cfg.target}/${name}";
        in
          if type == "directory" then
            processDirectory fullPath targetPath cfg
            
          else if type == "regular" then
            if shouldInclude fullPath relativeFromRoot then
              if shouldBeExecutable fullPath cfg.executable then
                { "${targetPath}" = { 
                    source = fullPath; 
                    executable = true; 
                  };
                }
              else
                { "${targetPath}".source = fullPath; }
            else
              {}
              
          else if type == "symlink" then
            { "${targetPath}".source = builtins.readLink fullPath; }
            
          else
            {};
            
    in
      builtins.foldl' (acc: entryName:
        acc // (processEntry entryName contents.${entryName})
      ) {} (builtins.attrNames contents);

  buildConfig = { name, path, ... }@args:
    let
      defaults = {
        executable = [];
        exclude = [];
        include = [];
        enabled = true;
        target = name;
        recursive = true;
        description = null;
      };
      
      cfg = defaults // args;
      
      pathExists = builtins.pathExists path;
    in
      if !cfg.enabled then
        (builtins.trace "Config '${name}' is disabled, skipping" {})
      else if !pathExists then
        (builtins.trace "Warning: Config path for '${name}' does not exist: ${toString path}" {})
      else
        processDirectory path cfg.target cfg;

  buildMany = configsList:
    builtins.foldl' (acc: cfg: acc // buildConfig cfg) {} configsList;

in
{
  from = name: path: buildConfig { inherit name path; };
  
  fromWith = attrs: buildConfig attrs;
  
  fromMany = buildMany;
  
  fromSimpleList = pathsList:
    builtins.listToAttrs (map (name: {
      name = name;
      value = buildConfig { 
        inherit name; 
        path = ./configs/${name};
      };
    }) pathsList);
  
  make = configs:
    builtins.foldl' (acc: name: 
      let
        value = configs.${name};
      in
        if builtins.isPath value then
          acc // (buildConfig { inherit name; path = value; })
        else if builtins.isAttrs value then
          acc // (buildConfig ({ inherit name; } // value))
        else
          acc
    ) {} (builtins.attrNames configs);
}