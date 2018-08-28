# Whatever.Skeleton

### Purpose of the project
Accelarate Visual Studio based project initial setup and project addition included with common needs.

### How to use your own template, configuration with your project
Just use the following parameters when you call `init.ps1` or `add-project.ps1` or `add-module.ps1` optionally:
- `configPath`
- `templatePath`
- `targetPath`

I suggest to download this repository and put it into your own, so your folder structure would look like this for instance:
- `Whatever.Skeleton`
    - `sk-configs`
    - `sk-queue`
    - `sk-scripts`
    - `sk-templates`
    - `target`
- `src`
- `...`

Change the following files/folders if you want to use your own template or configuration:
- `sk-configs\default.9.0.180604.config.json`
- `sk-templates\add-module\default\feature\`
- `sk-templates\add-project\default\feature\`
- `sk-templates\add-project\default\foundation\`
- `sk-templates\init\default\`

Create your own variants of the scripts, e.g.:
- `init.ps1 -targetPath "C:\projects\MyProject\src"`
- `add-project.ps1 -targetPath "C:\projects\MyProject\src"`
- `add-module.ps1 -targetPath "C:\projects\MyProject\src"`

So other developers from the team can use the scripts above.

### Commands
#### init.ps1
 1. Run the `init.ps1` PowerShell script from the `sk-scripts` folder, which sets up your solution based on `default.config.json` by default. Here is all the settings what you can change:
```
{
    "projectName": "MyProject",
    "targetFramework": "v4.6.2",
    "nugetTargetFramework": "net462",
    "aspNet": {
        "lib": "net45",
        "mvcVersion": "5.2.3",
        "webPagesVersion": "3.2.3",
        "razorVersion": "3.2.3"
    },
    "[guid]" : {
        "type" : "guid",
        "format": "D"
    },
    "[[subProjectId]]" : {
        "type" : "guid",
        "format" : "D"
    }
}
 2. Go to the target folder and open the solution in Visual Studio
```

#### add-project.ps1
 1. Run the `add-project.ps1` command with 2 required parameters:
    - `subProjectName`: name of the new project (e.g. `Navigation`)
    - `templateName`: name of the subfolder from `.\sk-templates\default` (`feature` or `foundation`)
 2. This command uses the same `default.config.json` config above
 3. Include the newly generated project to your Visual Studio solution manually

#### add-module.ps1
 1. Run the `add-module.ps1` command with 3 required parameters:
    - `moduleName`: name of the new module (e.g. `TextModule`)
    - `subProjectName`: name of the new project (e.g. `Navigation`)
    - `templateName`: name of the subfolder from `.\sk-templates\default` (`feature` or `foundation`)
 2. This command uses the same `default.config.json` config above
 3. Include the newly generated files to your Visual Studio project manually

### How to create your own template and configuration
#### Configuration
You can create your own configuration with the same parameter names or you can even create your custom parameters.
Only the `projectName` is a hardcoded and required parameter name but the others can be removed and changed.
#### Template
You can create your own templates (different, less complex or more complex), you just need to follow the following placeholder name convention:
- One level deep parameter: `[<parameterName>]` e.g. `[nugetTargetFramework]`
- Two or more level deep: `[<firstLevel>.<secondLevel>]` e.g. `[aspNet.lib]`
- `[guid]`: unique GUID generation in all places where it is used
- `[[subProjectId]]`: one-time GUID generation, so the same generated GUID is used in all places

**Important: your JSON configuration should be in sync with your template!**