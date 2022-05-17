%% example files in the OpenFAST glue-code regression tests:
caseFile = {'./glue-codes/openfast/CaseList.md', './glue-codes/openfast-cpp/CaseList.md'};
for iGlue=1:length(caseFile)
    [pathstr] = fileparts(caseFile{iGlue});
    
    fid = fopen(caseFile{iGlue});
    caseNames = textscan(fid,'%s');
    caseNames = caseNames{1};
    fclose(fid);
    
%     caseNames = {'5MW_Land_ModeShapes'}
    for i= 1:length(caseNames)
        casePath = [ pathstr filesep caseNames{i} ];
        ConvertFAST8_16to17( [casePath filesep caseNames{i} '.fst'], casePath );
    end
end

%% example files in the OpenFAST BeamDyn regression tests:
caseFile = './modules/beamdyn/CaseList.md';
[pathstr] = fileparts(caseFile);

fid = fopen(caseFile);
caseNames = textscan(fid,'%s');
caseNames = caseNames{1};
fclose(fid);

for i= 1:length(caseNames)
    casePath = [ pathstr filesep caseNames{i} ];
    ConvertBeamDynDriver( [casePath filesep 'bd_driver.inp'], casePath );  
end


%% example files in the OpenFAST BeamDyn documentation:
docsPath = '../../docs/source/user/beamdyn/examples/';
caseNames = strcat(docsPath, {'bd_driver_dynamic_nrel_5mw.inp', 'bd_driver_static_nrel_5mw.inp'} );

for i= 1:length(caseNames)
    ConvertBeamDynDriver( caseNames{i}, docsPath );  
end


%% example files in the OpenFAST AeroDyn documentation:
docsPath = '../../docs/source/user/aerodyn/examples/';
caseNames = strcat(docsPath, {'ad_driver_example.dvr'} );

for i= 1:length(caseNames)
    ConvertAeroDynDriver( caseNames{i}, docsPath );  
end

%% example files in the OpenFAST AeroDyn regression tests:
caseFile = './modules/aerodyn/CaseList.md';
[pathstr] = fileparts(caseFile);

fid = fopen(caseFile);
if fid > 0
    caseNames = textscan(fid,'%s');
    caseNames = caseNames{1};
    fclose(fid);

    for i= 1:length(caseNames)
        casePath = [ pathstr filesep caseNames{i} ];
        ConvertAeroDynDriver( [casePath filesep 'ad_driver.dvr'], casePath );  
    end
end

%% example files in the OpenFAST HydroDyn regression tests:
pathstr = './modules/hydrodyn/';
caseNames = GetSubDirsFirstLevelOnly(pathstr);

for i= 1:length(caseNames)
    casePath = fullfile(pathstr, caseNames{i});

    if strcmpi(caseNames{i},'HydroDyn_NBodyMod_cases')
        caseNamesSub = GetSubDirsFirstLevelOnly(casePath);
        for j=1:length(caseNamesSub)
            casePathSub = [ casePath filesep caseNamesSub{j} ];
            ConvertHydroDynDriver( [casePathSub filesep caseNamesSub{j} '.dvr'], casePathSub );          
        end
    else
        ConvertHydroDynDriver( [casePath filesep 'hd_driver.inp'], casePath );  
    end
end


