(* ::Package:: *)

(************************************************************************)
(* This file was generated automatically by the Mathematica front end.  *)
(* It contains Initialization cells from a Notebook file, which         *)
(* typically will have the same name as this file except ending in      *)
(* ".nb" instead of ".m".                                               *)
(*                                                                      *)
(* This file is intended to be loaded into the Mathematica kernel using *)
(* the package loading commands Get or Needs.  Doing so is equivalent   *)
(* to using the Evaluate Initialization Cells menu command in the front *)
(* end.                                                                 *)
(*                                                                      *)
(* DO NOT EDIT THIS FILE.  This entire file is regenerated              *)
(* automatically each time the parent Notebook file is saved in the     *)
(* Mathematica front end.  Any changes you make to this file will be    *)
(* overwritten.                                                         *)
(************************************************************************)



(* ::Input::Initialization:: *)
InstallCoDEx::notcomp="Your Mathematica version is older than 9. Installation aborted!";


(* ::Input::Initialization:: *)
InstallCoDEx::failed="Download of `1` failed. Installation aborted!";


(* ::Input::Initialization:: *)
InstallCoDExQuiet::usage="InstallCoDExQuiet is the silent mode of installing CoDEx, where the installer does not ask you any questions but silently overwrites any existing CoDEx installation and modifies Mathematica's options accordingly. The main purpose of this mode is to facilitate the installation of CoDEx on Mathematica Online.";


(* ::Input::Initialization:: *)
AutoOverwriteCoDExDirectory::usage="AutoOverwriteCoDExDirectory is an option of InstallCoDEx. If set to True, the existing CoDEx directory will be deleted without any further notice. The default
value None means that the user will be asked by a dialog. False means that the directory will be overwritten.";


(* ::Input::Initialization:: *)
AutoDisableInsufficientVersionWarning::usage="AutoDisableInsufficientVersionWarning is an option of InstallCoDEx. If set to True, warning messages for notebooks that were created with a newer Mathematica version will be silently disabled. This is needed to use CoDEx documentation in Mathematica 8 and 9, since otherwise the warning message will appear every time one opens a help page for a CoDEx function. The default value None means that the user will be asked by a dialog. False means that the warning will not be disabled.";


(* ::Input::Initialization:: *)
CoDExDevelopmentVersionLink::usage="CoDExDevelopmentVersionLink is an option of InstallCoDEx. It specifies the url to the main repository of CoDEx. This repository is used to install the development version of CoDEx.";


(* ::Input::Initialization:: *)
CoDExStableVersionLink::usage="CoDExStableVersionLink is an option of InstallCoDEx. It specifies the url to the latest stable release of CoDEx.";


(* ::Input::Initialization:: *)
InstallCoDExDevelopmentVersion::usage="InstallCoDExDevelopmentVersion is an option of InstallCoDEx. If set to True, the installer will download the latest development version of CoDEx from the git repository. Otherwise it will install the latest stable version.";


(* ::Input::Initialization:: *)
InstallCoDExTo::usage="InstallCoDExTo is an option of InstallCoDEx. It specifies, the full path to the directory where CoDEx will be installed.";


(* ::Input::Initialization:: *)
$PathToCDArc::usage="$PathToCDArc specifies where the installer should look for the zipped CoDEx version. If the value is not empty, the installer will use the specified file instead of downloading it from the official website."
If[!ValueQ[$PathToCDArc],$PathToCDArc=""];


(* ::Input::Initialization:: *)
Options[InstallCoDEx]={AutoDisableInsufficientVersionWarning->None,AutoOverwriteCoDExDirectory->None,CoDExDevelopmentVersionLink->"https://github.com/effExTeam/CoDEx-1.0.0/raw/master/CoDEx.zip",CoDExStableVersionLink->"https://github.com/effExTeam/CoDEx-1.0.0/raw/master/CoDEx.zip",InstallCoDExDevelopmentVersion->False,InstallCoDExTo->FileNameJoin[{$UserBaseDirectory,"Applications","CoDEx"}]};


(* ::Input::Initialization:: *)
Options[InstallCoDExQuiet]=Options[InstallCoDEx];


(* ::Input::Initialization:: *)
InstallCoDExQuiet[]:=InstallCoDEx[AutoDisableInsufficientVersionWarning->True,AutoOverwriteCoDExDirectory->True];


(* ::Input::Initialization:: *)
InstallCoDEx[OptionsPattern[]]:=
Module[{unzipDir,tmpzip,gitzip,packageName,packageDir,fullPath,strDisableWarning,CDGetUrl,configFileProlog,strOverwriteCDdit,zipDir},
If[OptionValue[InstallCoDExDevelopmentVersion],
gitzip=OptionValue[CoDExDevelopmentVersionLink],
gitzip=OptionValue[CoDExStableVersionLink]];
packageName="CoDEx";
packageDir=OptionValue[InstallCoDExTo];
strDisableWarning="To make the documentation work, we need to disable the warning that appears when you open a notebook that was created with a newer Mathematica version. Otherwise this warning will pop up every time you use the Documentation Center to read info on CoDEx functions in Mathematica 8 and 9. This setting is harmless and can be always undone via \"SetOptions[$FrontEnd, MessageOptions -> {\"InsufficientVersionWarning\" -> True}]\". Should we do this now?";
strOverwriteCDdit="Looks like CoDEx is already installed. Do you want to replace the content of "<>packageDir<>" with the downloaded version of CoDEx? If you are using any custom configuration files or add-ons that are located in that directory, please backup them in advance.";
configFileProlog="(*Here you can put some commands and settings to be evaluated on every start of CoDEx. \n This allows you to customize your CoDEx installation to fit your needs best.*)";
If[$VersionNumber<9,Message[InstallCoDEx::notcomp];
Abort[]];
CDGetUrl[x_]:=URLSave[x,CreateTemporary[]];

(*If the package directory already exists,ask the user about overwriting*)
If[DirectoryQ[packageDir],
If[OptionValue[AutoOverwriteCoDExDirectory],
Quiet@DeleteDirectory[packageDir,DeleteContents->True],
Null,
If[ChoiceDialog[strOverwriteCDdit,{"Yes, overwrite the "<>packageName<>" directory"->True,"No, I need to do a backup first. Abort installation."->False},
WindowFloating->True,WindowTitle->"Existing CoDEx Installation detected"],
Quiet@DeleteDirectory[packageDir,DeleteContents->True],
Abort[]]
]
];

(*Download CoDEx tarball*)
If[$PathToCDArc=!="",
tmpzip=$PathToCDArc;
WriteString["stdout","Installing CoDEx from ",tmpzip," ..."],
WriteString["stdout","Downloading CoDEx from ",gitzip," ..."];
tmpzip=CDGetUrl[gitzip];];
If[tmpzip===$Failed,
WriteString["stdout","\nFailed to download CoDEx. Please check your interent connection.\nInstallation aborted!"];Abort[],
unzipDir=tmpzip<>".dir";
WriteString["stdout","done! \n"];];

(*Extract to the content*)
WriteString["stdout","CoDEx zip file was saved to ",tmpzip,".\n"];
WriteString["stdout","Extracting CoDEx zip file to ",unzipDir," ..."];
If[ExtractArchive[tmpzip,unzipDir]===$Failed,
WriteString["stdout","\nFailed to extract the CoDEx zip. The file might be corrupted.\nInstallation aborted!"];
Abort[],
WriteString["stdout","done! \n"];

(*Delete the downloaded file*)
If[$PathToCDArc==="",Quiet@DeleteFile[tmpzip];]
];
WriteString["stdout","Recognizing the directory structure..."];
zipDir=FileNames["CoDEx.m",FileNameJoin[{unzipDir,"CoDEx"}],Infinity];
If[Length[zipDir]===1,
fullPath=DirectoryName[zipDir[[1]]];
zipDir=Last[FileNameSplit[DirectoryName[zipDir[[1]]]]];
WriteString["stdout","done! \n"],
WriteString["stdout","\nFailed to recognize the directory structure of the downloaded zip file. \nInstallation aborted!"];
Abort[]
];

(*Move the files to the final destination*)
WriteString["stdout","Copying "<>packageName<>" to ",packageDir," ..."];
If[CopyDirectory[fullPath,packageDir]===$Failed,
WriteString["stdout","\nFailed to copy "<>fullPath<>" to ",packageDir<>". \nInstallation aborted!"];
Abort[],
WriteString["stdout","done! \n"];
(*Delete the extracted archive*)
Quiet@DeleteDirectory[unzipDir,DeleteContents->True];
];
If[OptionValue[AutoDisableInsufficientVersionWarning],
SetOptions[$FrontEnd,MessageOptions->{"InsufficientVersionWarning"->False}],
Null,
If[ChoiceDialog[strDisableWarning,WindowFloating->True,WindowTitle->"Documentation system"],
SetOptions[$FrontEnd,MessageOptions->{"InsufficientVersionWarning"->False}]
]
];
WriteString["stdout","done! \n"];
(*RebuildPacletData[];*)
WriteString["stdout","\nInstallation complete! Loading CoDEx ... \n"];
Get["CoDEx`"];];
