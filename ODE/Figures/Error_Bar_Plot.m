function Error_Bar_Plot(Y,Y_Err,C_Plot)
    b=bar(Y,'LineStyle','none');
    if(length(b)>1)
        for bb=1:length(b)
            b(bb).FaceColor = 'flat';
            for ii=1:size(Y,1)
                b(bb).CData(ii,:) = C_Plot(bb,:);
            end
            hold on;
            lb=Y(:,bb)-Y_Err.LB(:,bb);
            ub=Y_Err.UB(:,bb)-Y(:,bb);
            er = errorbar(b(bb).XEndPoints,Y(:,bb),lb,ub,'LineWidth',Y_Err.LineWidth,'CapSize',Y_Err.Cap_Size);    
            er.Color = [0 0 0];                            
            er.LineStyle = 'none'; 
        end
    else
        b.FaceColor = 'flat';
        for ii=1:size(C_Plot,1)
            b.CData(ii,:) = C_Plot(ii,:);
        end
        hold on;
        lb=Y(:)-Y_Err.LB(:);
        ub=Y_Err.UB(:)-Y(:);
        er = errorbar(b.XData,Y,lb,ub,'LineWidth',Y_Err.LineWidth,'CapSize',Y_Err.Cap_Size);
        er.Color = [0 0 0];                            
        er.LineStyle = 'none';  

    end
end