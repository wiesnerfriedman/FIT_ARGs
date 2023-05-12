function [mdlSed, mdlWat]=GetPubPaper3Data()

%% GET PAPER 3 RESULTS AND RESPOND TO REVIEW COMMENTS

load('/Users/corinnewiesner/Desktop/Matlabworking/RunKewaunee2/KewauneeCode/ReviewResponse/ARGdatawSoil.mat')
load('/Users/corinnewiesner/Desktop/Matlabworking/RunKewaunee/KewauneeCode/Results/sSsR250mP3all.mat','szRt3')
missSed=szRt3{1, 2};
missWat=szRt3{2, 2};

SoilData=ARGdatawSoilProp(:,90:92);
SoilData=array2table(table2array(SoilData)>0.5);
SedSoilData=SoilData(~missSed,:);
WatSoilData=SoilData(~missWat,:);

%% ermB
%  
load('/Users/corinnewiesner/Desktop/Matlabworking/RunKewaunee/KewauneeCode/Results/ResultsTablesPaper3ermB_v1.mat')

InModelSed=Results(5, 1).Models.VariableInfo.InModel;
SedMat=Results(5, 1).Models.Variables(:,InModelSed);
SedMat(:,end+1:end+2)=SedSoilData; 
SedMat.Properties.VariableNames(end:-1:end-2)=[{'Soil10'}, {'Soil06'}, {'Soil01'}];
SedMat.Response=Results(5, 1).Models.Variables.Response;
mdlSed{1}=stepwiselm(SedMat,'constant','Upper','linear','Criterion','aic');



InModelWat=Results(5, 2).Models.VariableInfo.InModel;
WatMat=Results(5, 2).Models.Variables(:,InModelWat);
WatMat(:,end+1:end+3)=WatSoilData; 
WatMat.Properties.VariableNames(end:-1:end-2)=[{'Soil10'}, {'Soil06'}, {'Soil01'}];
WatMat.Response=Results(5, 2).Models.Variables.Response;
mdlWat{1}=stepwiselm(WatMat,'constant','Upper','linear','Criterion','aic');



%% tetW
% 
load('/Users/corinnewiesner/Desktop/Matlabworking/RunKewaunee/KewauneeCode/Results/ResultsTablesPaper3tetW_v1.mat')

InModelSed=Results(5, 1).Models.VariableInfo.InModel;
SedMat=Results(5, 1).Models.Variables(:,InModelSed);
SedMat(:,end+1:end+3)=SedSoilData; 
SedMat.Properties.VariableNames(end:-1:end-2)=[{'Soil10'}, {'Soil06'}, {'Soil01'}];
SedMat.Response=Results(5, 1).Models.Variables.Response;
mdlSed{2}=stepwiselm(SedMat,'constant','Upper','linear','Criterion','aic');



InModelWat=Results(5, 2).Models.VariableInfo.InModel;
WatMat=Results(5, 2).Models.Variables(:,InModelWat);
WatMat(:,end+1:end+3)=WatSoilData; 
WatMat.Properties.VariableNames(end:-1:end-2)=[{'Soil10'}, {'Soil06'}, {'Soil01'}];
WatMat.Response=Results(5, 2).Models.Variables.Response;
mdlWat{2}=stepwiselm(WatMat,'constant','Upper','linear','Criterion','aic');

%% qnrA 
load('/Users/corinnewiesner/Desktop/Matlabworking/RunKewaunee/KewauneeCode/Results/ResultsTablesPaper3qnrA_v1.mat')

InModelSed=Results(5, 1).Models.VariableInfo.InModel;
SedMat=Results(5, 1).Models.Variables(:,InModelSed);
SedMat(:,end+1:end+3)=SedSoilData; 
SedMat.Properties.VariableNames(end:-1:end-2)=[{'Soil10'}, {'Soil06'}, {'Soil01'}];
SedMat.Response=Results(5, 1).Models.Variables.Response;
mdlSed{3}=stepwiselm(SedMat,'constant','Upper','linear','Criterion','aic');



InModelWat=Results(5, 2).Models.VariableInfo.InModel;
WatMat=Results(5, 2).Models.Variables(:,InModelWat);
WatMat(:,end+1:end+3)=WatSoilData; 
WatMat.Properties.VariableNames(end:-1:end-2)=[{'Soil10'}, {'Soil06'}, {'Soil01'}];
WatMat.Response=Results(5, 2).Models.Variables.Response;
mdlWat{3}=stepwiselm(WatMat,'constant','Upper','linear','Criterion','aic');

%% sul1
load('/Users/corinnewiesner/Desktop/Matlabworking/RunKewaunee/KewauneeCode/Results/ResultsTablesPaper3sul1_v1.mat')

InModelSed=Results(5, 1).Models.VariableInfo.InModel;
SedMat=Results(5, 1).Models.Variables(:,InModelSed);
SedMat(:,end+1:end+3)=SedSoilData; 
SedMat.Properties.VariableNames(end:-1:end-2)=[{'Soil10'}, {'Soil06'}, {'Soil01'}];
SedMat.Response=Results(5, 1).Models.Variables.Response;
mdlSed{4}=stepwiselm(SedMat,'constant','Upper','linear','Criterion','aic');



InModelWat=Results(5, 2).Models.VariableInfo.InModel;
WatMat=Results(5, 2).Models.Variables(:,InModelWat);
WatMat(:,end+1:end+3)=WatSoilData; 
WatMat.Properties.VariableNames(end:-1:end-2)=[{'Soil10'}, {'Soil06'}, {'Soil01'}];
WatMat.Response=Results(5, 2).Models.Variables.Response;
mdlWat{4}=stepwiselm(WatMat,'constant','Upper','linear','Criterion','aic');

%% intI1

load('/Users/corinnewiesner/Desktop/Matlabworking/RunKewaunee/KewauneeCode/Results/ResultsTablesPaper3intI1_v1.mat')
load('/Users/corinnewiesner/Desktop/Matlabworking/RunKewaunee/KewauneeCode/Results/InformedSPsPaper3intI1_v1.mat')


newcol=SSVs(5, 1).InformedSPs.HDD2;  
TBL=Results(5, 1).Models.Variables;
Response=TBL.Response; 
TBL(:,end)=[]; 
TBL(:,"Devel2")=[];
TBL.HDD2=newcol; 
TBL.Response=Response; 

% re-run stepwise selection
mdl=stepwiselm(TBL,'constant','Upper','linear','Criterion','aic');

InModelSed=mdl.VariableInfo.InModel;
SedMat=mdl.Variables(:,InModelSed);
SedMat(:,end+1:end+3)=SedSoilData; 
SedMat.Properties.VariableNames(end:-1:end-2)=[{'Soil10'}, {'Soil06'}, {'Soil01'}];
SedMat.Response=mdl.Variables.Response;
mdlSed{5}=stepwiselm(SedMat,'constant','Upper','linear','Criterion','aic');



InModelWat=Results(5, 2).Models.VariableInfo.InModel;
WatMat=Results(5, 2).Models.Variables(:,InModelWat);
WatMat(:,end+1:end+3)=WatSoilData; 
WatMat.Properties.VariableNames(end:-1:end-2)=[{'Soil10'}, {'Soil06'}, {'Soil01'}];
WatMat.Response=Results(5, 2).Models.Variables.Response;
mdlWat{5}=stepwiselm(WatMat,'constant','Upper','linear','Criterion','aic');


