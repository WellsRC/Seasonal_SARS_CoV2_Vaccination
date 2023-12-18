function Error_Bar_Plot_SA(Y,Y_Err,C_Plot)
    b=bar(Y,'LineStyle','none');

    for bb=1:length(b)
        b(bb).FaceColor = 'flat';
        for ii=1:size(Y,1)
            b(bb).CData(ii,:) = C_Plot(bb+4.*(ii-1),:);
        end
        hold on;
        lb=Y(:,bb)-Y_Err.LB(:,bb);
        ub=Y_Err.UB(:,bb)-Y(:,bb);
        er = errorbar(b(bb).XEndPoints,Y(:,bb),lb,ub,'LineWidth',Y_Err.LineWidth,'CapSize',Y_Err.Cap_Size);    
        er.Color = [0 0 0];                            
        er.LineStyle = 'none'; 
    end
    
end