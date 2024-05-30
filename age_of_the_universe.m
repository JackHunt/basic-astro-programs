% *********************************************
% THIS PROGRAM COMPUTES THE AGE OF THE UNIVERSE
% FOR DIFFERENT VALUES OF THE HUBBLE PARAMETER,
% DENSITY PARAMETER, AND COSMOLOGICAL CONSTANT.
% FROM SKY & TELESCOPE, JANUARY 1996, PAGE 92.
% *********************************************
% 
% Translated from an old BASIC dialect by me (JH).
% 
clear;
clc;

% Hubble constant.
H0 = inputInRange('Hubble constant [25 to 150 (km/s)/Mpc]: ', 25, 150);

% Hubble time.
HT = (3.085678e19) / (H0 * 31557600);

% Omega zero.
OZ = inputInRange('Omega zero [0 to 5]: ', 0, 5);

% Omega lambda
if OZ == 0
    OS = 1;
elseif OZ == 1
    OS = 1.5 * sqrt(3);
else
    if OZ <= 0.5
        GM = (1 - OZ + sqrt(1 - 2 * OZ)) / OZ;
        X = 0.5 * (GM^(1/3) + GM^(-1/3));
    end

    if OZ > 0.5
        AL = atan(sqrt(2 * OZ - 1) / (1 - OZ));
    end

    if AL < 0
        AL = AL + 4 * atan(1);
    end

    if OZ > 0.5
        X = cos(AL / 3);
    end
end

OS = 4 * OZ * X^3;

fprintf('Omega lambda < %.10f gives Big Bang\n', OS);
fprintf('Omega lambda > %.10f gives no Big Bang\n', OS);

% Omega lambda
OL = inputInRange('Omega lambda [-10 to 10]: ', -10, 10);

clc;
disp(' Hubble constant    Omega zero    Omega lambda');
fprintf(' %3.0f (km/s)/Mpc     %2.4f    %3.10f\n', H0, OZ, OL);

% Plot settings
hold on;
axis([0 640 0 260]);
line([0 639], [5 260], 'Color', [0.7 0.7 0.7]);

title('Scale Factor vs. Time');

% Run calculations and plot
TL = -5;
TR = 5;
XP = -1;
for I = 1:4
    TN = 0;
    RN = 1;
    DN = 1;
    color = [1 0 0];
    if I == 4
        color = [0 0 1];
    end
    HN = 0.0025;
    if I == 1 || I == 3
        HN = -HN;
    end
    while true
        T = TN;
        R = RN;
        D = DN;
        DP = DN;
        TP = TN;

        F = OL * R - OZ / (2 * R^2);
        K1 = HN * F;
        L1 = HN * D;

        T = TN + HN / 2;
        R = RN + L1 / 2;
        D = DN + K1 / 2;

        F = OL * R - OZ / (2 * R^2);
        K2 = HN * F;
        L2 = HN * D;

        T = TN + HN / 2;
        R = RN + L2 / 2;
        D = DN + K2 / 2;

        F = OL * R - OZ / (2 * R^2);
        K3 = HN * F;
        L3 = HN * D;

        T = TN + HN;
        R = RN + L3;
        D = DN + K3;

        F = OL * R - OZ / (2 * R^2);
        K4 = HN * F;
        L4 = HN * D;

        TN = TN + HN;
        RP = RN;
        DP = DN;
        RN = RN + (L1 + 2 * L2 + 2 * L3 + L4) / 6;
        DN = DN + (K1 + 2 * K2 + 2 * K3 + K4) / 6;

        if RN < 0 || RN > 3 || TN < TL || TN > TR
            break;
        end

        if I > 2
            plot(640 * (TN - TL) / (TR - TL), 260 - RN * 85, '.', 'Color', color);
        end
    end

    if I == 1
        TL = TN;
    end
    
    if I == 2
        TR = TN * 1.1;

        assert(XP == -1);
        XP = 640 / (1 - TR / TL);
        
        plot(XP, 175, 'o', 'Color', [0.5 0.5 0.5]);
        line([XP XP], [250 260], 'Color', [1 1 1]);
    end
    
    if I == 3
        text(XP / 16, 19, 'PAST', 'Color', [1 0 0]);
    end

    A = XP / 8 - 2;
    if abs(A - 32) > 30
        A = 32 + 30 * sign(A - 32);
    end

    T = TN - HN - RP / DP;
    if OZ > 0
        T = T + RP / (3 * DP);
    end

    AG = abs(T * HT / 10^9);
    if I == 3
        text(A, 20, sprintf('%.1f billion years', AG), 'Color', [1 1 0]);
    end

    if I == 4
        text(37 + XP / 16, 19, 'FUTURE', 'Color', [0 0 1]);
    end
end
hold off;
