class Settings {
    # settings
    static [string] Sk_projectName() {
        return "[projectName]";
    }
    
    static [string] Sk_subProjectName() {
        return  "[subProjectName]";
    }

    static [string] Sk_moduleName() {
        return "[moduleName]";
    }

    # sk paths
    static [string] ScriptsRoot() {
        return Split-Path -Parent $PSScriptRoot;
    }
    
    static [string] Root() {
        return Split-Path -Parent ([Settings]::ScriptsRoot());
    }

    static [string] ExtensionRoot() {
        return Split-Path -Parent ([Settings]::Root());
    }

    static [string] RootTargetDir() {
        return Split-Path -Parent ([Settings]::ExtensionRoot());
    }

    static [string] TemplatesDir() {
        return Join-Path -Path ([Settings]::ExtensionRoot()) -ChildPath "sk-templates";
    }

    static [string] QueueDir() {
        return Join-Path -Path ([Settings]::Root()) -ChildPath "sk-queue";
    }

    static [string] TemplatesAddModuleDir() {
        return Join-Path -Path ([Settings]::TemplatesDir()) -ChildPath "add-module";
    }

    static [string] TemplatesAddProjectDir() {
        return Join-Path -Path ([Settings]::TemplatesDir()) -ChildPath "add-project";
    }

    static [string] TemplatesInitDir() {
        return Join-Path -Path ([Settings]::TemplatesDir()) -ChildPath "init";
    }

    static [string] ConfigsDir() {
        return Join-Path -Path ([Settings]::ExtensionRoot()) -ChildPath "sk-configs";
    }

    static [string] DefaultTargetDir() {
        return Join-Path -Path ([Settings]::ExtensionRoot()) -ChildPath "target";
    }
}