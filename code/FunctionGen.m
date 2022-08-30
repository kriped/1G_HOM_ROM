function functionlist = FunctionGen(mend)

strlist = strings(1,mend);
for m = 1:mend
    %For each m make a new set of 3 equations
    PhiString = sprintf(['v*((-XS_HOMO.D*bsqmn(%1$i)+sigmaE)*s((%1$i-1)*3+1)'],m);
    IodineString=sprintf(['gammaI*XS_HOMO.NF/(nu*keff)*s((%1$i-1)*3+1)-lambdaI*s((%1$i-1)*3+2);' newline],m);
    XenonString = sprintf(['lambdaI*s((%1$i-1)*3+2)' ...
        '+gammaX*XS_HOMO.NF/(keff*nu)*s((%1$i-1)*3+1)' ...
        '-lambdaX*s((%1$i-1)*3+3)'],m);
    for n = 1:mend
        % Add new terms to each phi and xenon eqs for each equation
        newstr_P = sprintf(['+FB*phi0mn(%1$i,%2$i)*s((%1$i-1)*3+1)' ...
            '-sigmaX*phi0mn(%1$i,%2$i)*s((%1$i-1)*3+3)'],n,m);
        PhiString = [PhiString newstr_P];
        newstr_X = sprintf(['-sigmaX*X0mn(%1$i,%2$i)*s((%1$i-1)*3+1)' ...
            '-sigmaX*phi0mn(%1$i,%2$i)*s((%1$i-1)*3+3)'],n,m);
        XenonString = [XenonString newstr_X];
    end
    %edit end of strings
    %PhiString(end-1:end) = [];
    PhiString = [PhiString,');',newline];
    XenonString = [XenonString,';',newline];
    %XenonString(end-1:end) = [];
    %XenonString(end-2:end) = [');' newline];
    strlist(m)= [PhiString newline IodineString newline XenonString newline]; % Combine for complete function string
end
% make string into vector and edit the end
functionlist = char(join(strlist));
functionlist=functionlist(1:end-1);
%functionString = ['g = @(t,s)[' functionlist ']'];
%eval(functionString);
%func = str2func(functionString); %convert string vector to function
end