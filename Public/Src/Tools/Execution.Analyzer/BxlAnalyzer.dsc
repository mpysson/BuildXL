// Copyright (c) Microsoft. All rights reserved.
// Licensed under the MIT license. See LICENSE file in the project root for full license information.

import * as Managed from "Sdk.Managed";
namespace Execution.Analyzer {

    export declare const qualifier: BuildXLSdk.DefaultQualifier;

    @@public
    export const exe = BuildXLSdk.executable({
        assemblyName: "bxlanalyzer",
        appConfig: f`App.Config`,
        generateLogs: true,
        rootNamespace: "BuildXL.Execution.Analyzer",
        skipDocumentationGeneration: true,
        sources: globR(d`.`, "*.cs"),
        references: [
            ...addIfLazy(BuildXLSdk.isFullFramework, () => [
                NetFx.System.IO.dll,
                NetFx.System.Web.dll,
                NetFx.System.Xml.dll,
                NetFx.System.Xml.Linq.dll,
                NetFx.System.IO.Compression.dll,
                NetFx.System.Net.Http.dll,
                NetFx.System.Runtime.Serialization.dll,
            ]),
            ...(BuildXLSdk.isDotNetCoreBuild 
                // There is a bug in the dotnetcore generation of this package
                ? [importFrom("Microsoft.IdentityModel.Clients.ActiveDirectory").withQualifier({targetFramework: "netstandard1.3"}).pkg]
                : [importFrom("Microsoft.IdentityModel.Clients.ActiveDirectory").pkg]
            ),
            importFrom("BuildXL.Cache.VerticalStore").Interfaces.dll,
            importFrom("BuildXL.Cache.ContentStore").Hashing.dll,
            importFrom("BuildXL.Cache.ContentStore").UtilitiesCore.dll,
            importFrom("BuildXL.Cache.ContentStore").Interfaces.dll,
            importFrom("BuildXL.Cache.MemoizationStore").Interfaces.dll,
            importFrom("BuildXL.Pips").dll,
            importFrom("BuildXL.Engine").Cache.dll,
            importFrom("BuildXL.Engine").Engine.dll,
            importFrom("BuildXL.Engine").Processes.dll,
            importFrom("BuildXL.Engine").Scheduler.dll,
            importFrom("BuildXL.Ide").Generator.dll,
            importFrom("BuildXL.Utilities").dll,
            importFrom("BuildXL.Utilities").Branding.dll,
            importFrom("BuildXL.Utilities").Native.dll,
            importFrom("BuildXL.Utilities").Script.Constants.dll,
            importFrom("BuildXL.Utilities").Storage.dll,
            importFrom("BuildXL.Utilities").ToolSupport.dll,
            importFrom("BuildXL.Utilities.Instrumentation").Common.dll,
            importFrom("BuildXL.Utilities.Instrumentation").Tracing.dll,
            importFrom("BuildXL.Utilities").Collections.dll,
            importFrom("BuildXL.Utilities").Configuration.dll,
            importFrom("Newtonsoft.Json").pkg,
            importFrom("Microsoft.TeamFoundationServer.Client").pkg,
            importFrom("Microsoft.VisualStudio.Services.Client").pkg,
            importFrom("Microsoft.VisualStudio.Services.InteractiveClient").pkg,
        ],
        internalsVisibleTo: [
            "Test.Tool.Analyzers",
        ],
        defineConstants: addIf(BuildXLSdk.Flags.isVstsArtifactsEnabled,
            "FEATURE_VSTS_ARTIFACTSERVICES"
        ),
    });
}
