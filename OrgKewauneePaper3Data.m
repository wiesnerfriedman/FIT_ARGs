function [sSsRpathname,szS3,szSuse,jtog, szRt3]=OrgKewauneePaper3Data(pathname,sSsRpathname)
%% sS -- can make into cell arrays for option format

rr=sSsRpathname;

if exist(rr)
    load(rr)
else
    q1=sprintf('%s%s',pathname,'/KewauneeCode/Data/SourceandObservationcopy.mat');
    q2=sprintf('%s%s',pathname,'/KewauneeCode/Data/SourceandObservation.mat');
    q3=sprintf('%s%s',pathname,'/KewauneeCode/Data/WisclandPolygonFiles.mat');
    load(q1)
    load(q2)
    load(q3)
    
    d1=sprintf('%s%s',pathname,'/KewauneeCode/Data/ManureStorageSimFinal.mat');
    d2=sprintf('%s%s',pathname,'/KewauneeCode/Data/WisclandData.mat');
    d3=sprintf('%s%s',pathname,'/KewauneeCode/Data/DrainfieldsSimFinal.mat');
    d4=sprintf('%s%s',pathname,'/KewauneeCode/Data/SanSystSimFinal.mat');
  
    for i=1:27
        SourceCase=i;
        switch SourceCase
            case 1 %  Manure Storages + simulated counts per outer quadrant
                load(d1,'zScountOUT','sSOUT')
                sS=[sS_CAFO.Xsp sS_CAFO.Ysp;sSOUT];
                zS1=sS_CAFO.lntotGal;
                zS1(isnan(zS1))=nanmean(zS1);
                zScountOUTltg=mean(zS1)*zScountOUT;
                zS=[zS1;zScountOUTltg];
                zS(isnan(zS))=0;
                iS='Manure Storages w Sim Counts per Outer Quadrant';
                catS='CAFO';
                use=1;
                rel='ManureApp';
            case 2 % Crop Rotation (Area type)
                dat=CropRoationAreas;
                zS=lz(dat.Area,2);
                sx=dat.Xsp;
                sy=dat.Ysp;
                sS=[sx sy];
                iS='Crop Rotation (Area)';
                catS='ManureApp';
                use=1;
                rel='na';
            case 3 % Dairy Rotation Points
                load(d2,'sS_CropRota')
                idx=sS_CropRota.CLS_DESC_3=='Dairy Rotation';
                sx=sS_CropRota.Xsp(idx);
                sy=sS_CropRota.Ysp(idx);
                sS=[sx sy];
                zS=ones(size(sx));
                iS='Dairy Rotation (Points)';
                catS='ManureApp';
                use=0;
                rel='na';
            case 4 %  Manure storages without log total gallons
                sS=[sS_CAFO.Xsp sS_CAFO.Ysp];
                zS=ones(size(sS_CAFO.Xsp));
                iS='Kewaunee Manure Storages (not weighted)';
                catS='CAFO';
                use=0;
                rel='ManureApp';
            case 5 % Manure storages without log total gallons real data and simulated outside
                load(d1,'zScountOUT','sSOUT')
                sS=[sS_CAFO.Xsp sS_CAFO.Ysp;sSOUT];
                zS1=ones(size(sS_CAFO.Xsp));
                zS=[zS1;zScountOUT];
                zS(isnan(zS))=0;
                iS='Manure Storages (unweighted) w simulated density outside of Kewaunee';
                catS='CAFO';
                use=1;
                rel='ManureApp';
            case 6 % dairy rotation polygon centroid + area
                load(d2,'dairy')
                sS=[dairy.Xsp dairy.Ysp];
                zS=lz(dairy.Area,2);
                iS='Dairy Rotation (area type)';
                catS='ManureApp';
                use=1;
                rel='na';
            case 7 % DNR Active CAFO Permit Points (unweighted)
                dat=DNRCAFOsubst;
                sS=[dat.Xsp dat.Ysp];
                zS=ones(size(dat.Xsp));
                iS='DNR Active CAFO Permit Points (unweighted)';
                catS='CAFO';
                use=1;
                rel='ManureApp';
            case 8 % Drainfields + simulated counts per outer quadrant
                load(d3)
                sx=sS_Drainfield.Xsp;
                sy=sS_Drainfield.Ysp;
                sx(isnan(sS_SanSyst.Xsp))=[];
                sy(isnan(sS_SanSyst.Xsp))=[];
                zS1=ones(size(sx));
                sS1=[sx sy];
                sS=[sS1;sSOUT];
                zScountOUT(isnan(zScountOUT))=0;
                zS=[zS1;zScountOUT];
                iS='Drainfields w simulated counts per outer quadrant';
                catS='Sep';
                use=1;
                rel='DomLAS';
            case 9 %  municipal WWTPs
                sx=municipalWPDES.Xsp;
                sy=municipalWPDES.Ysp;
                zS=municipalWPDES.Population;
                sS=[sx sy];
                iS='Municipal WWTPs';
                catS='WWTP';
                use=1;
                rel='DomLAS';
            case 10  % industrial WWTPs
                sx=industrialWPDES.Xsp;
                sy=industrialWPDES.Ysp;
                zS=ones(size(sx));
                sS=[sx sy];
                iS='Industrial WWTPs';
                catS='WWTP';
                use=1;
                rel='IndLAS';
            case 11 % all developed polygon centroid + area
                load(d2,'dev')
                sS=[dev.Xsp dev.Ysp];
                zS=lz(dev.Area,2);
                iS='Developed (area type)';
                catS='Devel';
                use=0;
                rel='na';
            case 12 %low-intensity developed polygon centroid + area
                load(d2,'dev')
                sS=[dev.Xsp dev.Ysp];
                zS=lz(dev.Area,2);
                idx=(dev.type=='Developed, Low Intensity');
                sS(~idx,:)=[];
                zS(~idx,:)=[];
                iS='Low Density Developed (area type)';
                catS='LDD';
                use=1;
                rel='na';
            case 13 %  high-intensity developed polygon centroid + area
                load(d2,'dev')
                sS=[dev.Xsp dev.Ysp];
                zS=lz(dev.Area,2);
                idx=(dev.type=='Developed, High Intensity');
                sS(~idx,:)=[];
                zS(~idx,:)=[];
                iS='High Density Developed (area type)';
                catS='HDD';
                use=1;
                rel='na';
            case 14 % sanitary systems + sim
                load(d4,'sScomp','zScomp','sSOUT','zSOUT','zScountOUT');
                sS=[sS_SanSyst.Xsp sS_SanSyst.Ysp;sSOUT];
                zS=[ones(size(sS_SanSyst.Xsp)); zScountOUT];
                iS='Sanitary Systems + density per quadrant outside of Door/Kewaunee';
                catS='Sep';
                use=1;
                rel='DomLAS';
            case 15 % Developed Low Density (points)
                load(d2,'sS_Devel')
                dat=sS_Devel;
                idx=dat.CLS_DESC_2=='Developed, Low Intensity';
                sx=dat.Xsp(idx);
                sy=dat.Ysp(idx);
                sS=[sx sy];
                zS=ones(size(sx));
                iS='Low Density Developed (points)';
                catS='LDD';
                use=1;
                rel='na';
            case 16 % Developed High Density (points)
                load('WisclandData.mat','sS_Devel')
                dat=sS_Devel;
                idx=dat.CLS_DESC_2=='Developed, High Intensity';
                sx=dat.Xsp(idx);
                sy=dat.Ysp(idx);
                sS=[sx sy];
                zS=ones(size(sx));
                iS='High Density Developed (points)';
                catS='HDD';
                use=1;
                rel='na';
            case 17 %  All unweighted wastewater treatment plant locations
                sS=[industrialWPDES.Xsp industrialWPDES.Ysp;municipalWPDES.Xsp municipalWPDES.Ysp];
                zS=ones(size(sS(:,1)));
                iS='All Unweighted Wastewater Treatment Plants';
                catS='WWTP';
                use=1;
                rel='LAS';
            case 18 % ORR Sites No Weighting Points
                dat=ORRSITES;
                sS=[dat.Xsp dat.Ysp];
                zS=ones(size(dat.Xsp));
                idxIN=inpolygon(sS(:,1),sS(:,2),maskshapeX,maskshapeY);
                sS=sS(idxIN,:);
                zS=zS(idxIN);
                iS='DNR ORR Sites No Weighting';
                catS='LAS';
                use=1;
                rel='na';
            case 19 % ORR Sites Weighted by Acrage
                dat=ORRSITES;
                sS=[dat.Xsp dat.Ysp];
                idxnan=isnan(ORRSITES.ApprovedAcres); 
                idx0=ORRSITES.ApprovedAcres==0; 
                zS=ORRSITES.ApprovedAcres; 
                zS(idxnan|idx0)=min(zS(zS~=0)); 
                zS=lz(zS,2);
                idxIN=inpolygon(sS(:,1),sS(:,2),maskshapeX,maskshapeY);
                sS=sS(idxIN,:);
                zS=zS(idxIN);
                iS='DNR ORR Sites Weighted By Acrage';
                catS='LAS';
                use=1;
                rel='na';
            case 20 % ORR Sites with Industrial Sludge
                dat=ORRSITES;
                sS=[dat.Xsp dat.Ysp];
                idxnan=isnan(ORRSITES.ApprovedAcres); 
                idx0=ORRSITES.ApprovedAcres==0; 
                zS=ORRSITES.ApprovedAcres; 
                zS(idxnan|idx0)=min(zS(zS~=0)); 
                zS=lz(zS,2);
                idx=dat.IndustrialSludge=='N';
                sS(idx,:)=[];
                zS(idx)=[];
                idxIN=inpolygon(sS(:,1),sS(:,2),maskshapeX,maskshapeY);
                sS=sS(idxIN,:);
                zS=zS(idxIN);
                iS='DNR ORR Sites from Industrial Sludge';
                catS='IndLAS';
                use=1;
                rel='na';
            case 21 % ORR Sites with Papermill Sludge
                dat=ORRSITES;
                sS=[dat.Xsp dat.Ysp];
                idxnan=isnan(ORRSITES.ApprovedAcres); 
                idx0=ORRSITES.ApprovedAcres==0; 
                zS=ORRSITES.ApprovedAcres; 
                zS(idxnan|idx0)=min(zS(zS~=0)); 
                zS=lz(zS,2);
                idx=dat.Papermill=='N';
                sS(idx,:)=[];
                zS(idx)=[];
                idxIN=inpolygon(sS(:,1),sS(:,2),maskshapeX,maskshapeY);
                sS=sS(idxIN,:);
                zS=zS(idxIN);
                iS='DNR ORR Sites from Papermill Sludge';
                catS='IndLAS';
                use=1;
                rel='na';
            case 22 % ORR Sites with food processing
                dat=ORRSITES;
                sS=[dat.Xsp dat.Ysp];
                idxnan=isnan(ORRSITES.ApprovedAcres); 
                idx0=ORRSITES.ApprovedAcres==0; 
                zS=ORRSITES.ApprovedAcres; 
                zS(idxnan|idx0)=min(zS(zS~=0)); 
                zS=lz(zS,2);
                idx=dat.FoodProcessing=='N';
                sS(idx,:)=[];
                zS(idx)=[];
                idxIN=inpolygon(sS(:,1),sS(:,2),maskshapeX,maskshapeY);
                sS=sS(idxIN,:);
                zS=zS(idxIN);
                iS='DNR ORR Sites from Food Processing';
                catS='IndLAS';
                use=1;
                rel='na';
            case 23 % ORR Sites with Septage
                dat=ORRSITES;
                sS=[dat.Xsp dat.Ysp];
                idxnan=isnan(ORRSITES.ApprovedAcres); 
                idx0=ORRSITES.ApprovedAcres==0; 
                zS=ORRSITES.ApprovedAcres; 
                zS(idxnan|idx0)=min(zS(zS~=0)); 
                zS=lz(zS,2);
                idx=dat.Septage=='N';
                sS(idx,:)=[];
                zS(idx)=[];
                idxIN=inpolygon(sS(:,1),sS(:,2),maskshapeX,maskshapeY);
                sS=sS(idxIN,:);
                zS=zS(idxIN);
                iS='DNR ORR Sites from Septage';
                catS='DomLAS';
                use=1;
                rel='na';
            case 24 % Acid Whey Land Application
                dat=ORRSITES;
                sS=[dat.Xsp dat.Ysp];
                idxnan=isnan(ORRSITES.ApprovedAcres); 
                idx0=ORRSITES.ApprovedAcres==0; 
                zS=ORRSITES.ApprovedAcres; 
                zS(idxnan|idx0)=min(zS(zS~=0)); 
                zS=lz(zS,2);
                idx=dat.Whey=='N';
                sS(idx,:)=[];
                zS(idx)=[];
                idxIN=inpolygon(sS(:,1),sS(:,2),maskshapeX,maskshapeY);
                sS=sS(idxIN,:);
                zS=zS(idxIN);
                iS='DNR ORR Sites from Acid Whey';
                catS='IndLAS';
                use=1;
                rel='na';
            case 25  % Industrial WW and Industrial Sludge (From Dairy or Meat Production)
                dat=ORRSITES;
                sS=[dat.Xsp dat.Ysp];
                idxnan=isnan(ORRSITES.ApprovedAcres); 
                idx0=ORRSITES.ApprovedAcres==0; 
                zS=ORRSITES.ApprovedAcres; 
                zS(idxnan|idx0)=min(zS(zS~=0)); 
                zS=lz(zS,2);
                idx=(dat.IndustrialWW=='N')&(dat.IndustrialSludge=='N');
                sS(idx,:)=[];
                zS(idx)=[];
                idxIN=inpolygon(sS(:,1),sS(:,2),maskshapeX,maskshapeY);
                sS=sS(idxIN,:);
                zS=zS(idxIN);
                iS='DNR ORR Sites from Industrial WW and Industrial Sludge';
                catS='IndLAS';
                use=1;
                rel='na';
            case 26  % Municipal WW Treatment
                dat=ORRSITES;
                sS=[dat.Xsp dat.Ysp];
                idxnan=isnan(ORRSITES.ApprovedAcres); 
                idx0=ORRSITES.ApprovedAcres==0; 
                zS=ORRSITES.ApprovedAcres; 
                zS(idxnan|idx0)=min(zS(zS~=0)); 
                zS=lz(zS,2);
                idx=(dat.MunicipalWW=='N');
                sS(idx,:)=[];
                zS(idx)=[];
                idxIN=inpolygon(sS(:,1),sS(:,2),maskshapeX,maskshapeY);
                sS=sS(idxIN,:);
                zS=zS(idxIN);
                iS='DNR ORR Sites from Municipal WW Treatment';
                catS='DomLAS';
                use=1;
                rel='na';
            case 27 % Municipal WW Treatment or Septage
                dat=ORRSITES;
                sS=[dat.Xsp dat.Ysp];
                idxnan=isnan(ORRSITES.ApprovedAcres); 
                idx0=ORRSITES.ApprovedAcres==0; 
                zS=ORRSITES.ApprovedAcres; 
                zS(idxnan|idx0)=min(zS(zS~=0)); 
                zS=lz(zS,2);
                idx=(dat.MunicipalWW=='N')&(dat.Septage=='N') ;
                sS(idx,:)=[];
                zS(idx)=[];
                idxIN=inpolygon(sS(:,1),sS(:,2),maskshapeX,maskshapeY);
                sS=sS(idxIN,:);
                zS=zS(idxIN);
                iS='DNR ORR Sites from Municipal WW Treatment or Septage';
                catS='DomLAS';
                use=1;
                rel='na';
            case 28 % DNR Active CAFO Permit Points (weighted by animal units)
                dat=DNRCAFOsubst;
                sS=[dat.Xsp dat.Ysp];
                zS=dat.AU;
                iS='DNR Active CAFO Permit Points (weighted by AUs)';
                catS='CAFO';
                use=1;
                rel='ManureApp';
        end
        idxIN=inpolygon(sS(:,1),sS(:,2),maskS(:,1),maskS(:,2)); % only within a certain area
        szS3{i,1}=[sS(idxIN,:) zS(idxIN)];
        szS3{i,2}=iS;
        szS3{i,3}=catS;
        szSuse(i)=use;
        jtog{i}=rel;
    end
    
    %% sR -- can make into cell arrays for option format
    
    %load the river network snap the observation/response points to the river network
    q4=sprintf('%s%s',pathname,'/KewauneeCode/Results/FinalRiverNetworkSep2020_250m.mat');
    load(q4)

    sRO=[ARGdata.Xsp ARGdata.Ysp];
    sRRmat=snapMS2river(FI,sRO,0); %make sure the sampling sites are on the river network
    
    for j=1:8
        ObservationCase=j;
        switch ObservationCase
            case 1 % ermB in sediment
                sR=sRRmat(:,1:2); % save river network points for response
                rR=sRRmat(:,3:5); % save river network info for response points
                zR=ARGdata3.ermB_Sed;
                tR=month(datetime(ARGdata.Datnum,'ConvertFrom','datenum'));
                idxnan=isnan(zR);
                sR(idxnan,:)=[];
                zR(idxnan)=[];
                tR(idxnan)=[];
                rR(idxnan,:)=[];
                flowtype=2;
                % Euclidean
                Ebounds=[50 34000];
                % River Distance
                Rbounds=[50 3000];
                % Overland Flow
                Obounds=[2000 20000];
                % Ground Transport
                Gbounds=[50 34000];

        case 2 % ermB in water
                sR=sRRmat(:,1:2);
                rR=sRRmat(:,3:5);
                zR=ARGdata3.ermB_Water;
                zR(zR==0)=min(zR(zR>0))/1.09;
                zR(zR==-9999)=min(zR(zR>0))/1.05;
                tR=month(datetime(ARGdata.Datnum,'ConvertFrom','datenum'));
                idxnan=isnan(zR);
                zR(idxnan)=[];
                sR(idxnan,:)=[];
                tR(idxnan)=[];
                rR(idxnan,:)=[];
                flowtype=2;
                Ebounds=[50 10000];
                % River Distance
                Rbounds=[50 10000];
                % Overland Flow
                Obounds=[50 10000];
                % Ground Transport
                Gbounds=[50 34000];
        case 3 % tetW in sediment
                sR=sRRmat(:,1:2); % save river network points for response
                rR=sRRmat(:,3:5); % save river network info for response points
                zR=ARGdata3.tetW_Sed;
                tR=month(datetime(ARGdata.Datnum,'ConvertFrom','datenum'));
                idxnan=isnan(zR);
                sR(idxnan,:)=[];
                zR(idxnan)=[];
                tR(idxnan)=[];
                rR(idxnan,:)=[];
                flowtype=2;
                % Euclidean
                Ebounds=[50 34000];
                % River Distance
                Rbounds=[50 3000];
                % Overland Flow
                Obounds=[2000 20000];
                % Ground Transport
                Gbounds=[50 34000];

 
            case 4 % tetW in water
                sR=sRRmat(:,1:2);
                rR=sRRmat(:,3:5);
                zR=ARGdata3.tetW_Water;
                zR(zR==0)=min(zR(zR>0))/1.09;
                zR(zR==-9999)=min(zR(zR>0))/1.05;
                tR=month(datetime(ARGdata.Datnum,'ConvertFrom','datenum'));
                idxnan=isnan(zR);
                zR(idxnan)=[];
                sR(idxnan,:)=[];
                tR(idxnan)=[];
                rR(idxnan,:)=[];
                flowtype=2;
                Ebounds=[50 10000];
                % River Distance
                Rbounds=[50 10000];
                % Overland Flow
                Obounds=[50 10000];
                % Ground Transport
                Gbounds=[50 34000];
                
            case 5 % qnrA in sediment
                sR=sRRmat(:,1:2); % save river network points for response
                rR=sRRmat(:,3:5); % save river network info for response points
                zR=ARGdata3.qnrA_Sed;
                tR=month(datetime(ARGdata.Datnum,'ConvertFrom','datenum'));
                idxnan=isnan(zR);
                sR(idxnan,:)=[];
                zR(idxnan)=[];
                tR(idxnan)=[];
                rR(idxnan,:)=[];
                flowtype=2;
               % Euclidean
                Ebounds=[50 34000];
                % River Distance
                Rbounds=[50 3000];
                % Overland Flow
                Obounds=[2000 20000];
                % Ground Transport
                Gbounds=[50 34000];
 
        case 6 % qnrA in water
                sR=sRRmat(:,1:2);
                rR=sRRmat(:,3:5);
                zR=ARGdata3.qnrA_Water;
                zR(zR==0)=min(zR(zR>0))/1.09;
                zR(zR==-9999)=min(zR(zR>0))/1.05;
                tR=month(datetime(ARGdata.Datnum,'ConvertFrom','datenum'));
                idxnan=isnan(zR);
                zR(idxnan)=[];
                sR(idxnan,:)=[];
                tR(idxnan)=[];
                rR(idxnan,:)=[];
                flowtype=2;
                Ebounds=[50 10000];
                % River Distance
                Rbounds=[50 10000];
                % Overland Flow
                Obounds=[50 10000];
                % Ground Transport
                Gbounds=[50 34000];
        case 7 % sul1 in sediment
                sR=sRRmat(:,1:2); % save river network points for response
                rR=sRRmat(:,3:5); % save river network info for response points
                zR=ARGdata3.sul1_Sed;
                tR=month(datetime(ARGdata.Datnum,'ConvertFrom','datenum'));
                idxnan=isnan(zR);
                sR(idxnan,:)=[];
                zR(idxnan)=[];
                tR(idxnan)=[];
                rR(idxnan,:)=[];
                flowtype=2;
               % Euclidean
                Ebounds=[50 34000];
                % River Distance
                Rbounds=[50 3000];
                % Overland Flow
                Obounds=[2000 20000];
                % Ground Transport
                Gbounds=[50 34000];
            case 8 % sul1 in water
                sR=sRRmat(:,1:2);
                rR=sRRmat(:,3:5);
                zR=ARGdata3.sul1_Water;
                zR(zR==0)=min(zR(zR>0))/1.09;
                zR(zR==-9999)=min(zR(zR>0))/1.05;
                tR=month(datetime(ARGdata.Datnum,'ConvertFrom','datenum'));
                idxnan=isnan(zR);
                zR(idxnan)=[];
                sR(idxnan,:)=[];
                tR(idxnan)=[];
                rR(idxnan,:)=[];
                flowtype=2;
                Ebounds=[50 10000];
                % River Distance
                Rbounds=[50 10000];
                % Overland Flow
                Obounds=[50 10000];
                % Ground Transport
                Gbounds=[50 34000];
           case 9 % intI in sediment
                sR=sRRmat(:,1:2); 
                rR=sRRmat(:,3:5); 
                zR=ARGdata3.intI1_Sed;
                zR(zR==0)=min(zR(zR>0))/1.09;
                zR(zR==-9999)=min(zR(zR>0))/1.05;
                tR=month(datetime(ARGdata.Datnum,'ConvertFrom','datenum'));
                idxnan=isnan(zR);
                zR(idxnan)=[];
                sR(idxnan,:)=[];
                tR(idxnan)=[];
                rR(idxnan,:)=[];
                flowtype=2;
               % Euclidean
                Ebounds=[50 34000];
                % River Distance
                Rbounds=[50 3000];
                % Overland Flow
                Obounds=[2000 20000];
                % Ground Transport
                Gbounds=[50 34000];
        case 10 % intI in water
                sR=sRRmat(:,1:2);
                rR=sRRmat(:,3:5);
                zR=ARGdata3.intI1_Wate;
                zR(zR==0)=min(zR(zR>0))/1.09;
                zR(zR==-9999)=min(zR(zR>0))/1.05;
                tR=month(datetime(ARGdata.Datnum,'ConvertFrom','datenum'));
                idxnan=isnan(zR);
                zR(idxnan)=[];
                sR(idxnan,:)=[];
                tR(idxnan)=[];
                rR(idxnan,:)=[];
                flowtype=2;
                Ebounds=[50 10000];
                % River Distance
                Rbounds=[50 10000];
                % Overland Flow
                Obounds=[50 10000];
                % Ground Transport
                Gbounds=[50 34000];

        end        
        szRt3{ObservationCase,1}=[sR zR tR rR];
        szRt3{ObservationCase,2}=idxnan;
        szRt3{ObservationCase,3}=2;
        E{ObservationCase}=Ebounds;
        R{ObservationCase}=Rbounds;
        O{ObservationCase}=Obounds;
        G{ObservationCase}=Gbounds;
    end

   save(rr,'szS3','szSuse','jtog', 'szRt3','E','R','O','G')
