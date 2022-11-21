clear
clc
close all

% Load Data
% Data shall have the following structure
% Data.grainID: grainID
% Data.X: X coordinates of data points
% Data.Y: Y coordinates of data points
% Data.phi1: phi1 Bunge angle
% Data.Phi: Phi Bunge angle
% Data.phi2: phi2 Bunge angle



load('Example\Data.mat')

nodata=size(Data.grainId,1);

%load('E:\eralp\UoB\Oxford_StressData\full data\Undeformed_FullMaps.mat')



addpath('FE')



% INPUTS
% Specify the nearest neighbors
nn=4;

% % Limit for CI below which is trash
% CIlim=5;

% EBSD step size
ss=0.4950;







% Constraint penalty factor
lambda=10;

% Burgers vector for GND analysis
% Check for steel (in micrometers)
Burger = 0.286e-3;


% Size conversion factor
% 1/Micrometer^2 to 1/meter^2
SF=1e12;


% ANALYSIS
% Step 1. Clean-up the data
[Data] = cleanup(Data, nn, ss, nodata);
disp('cleanup completed!')

% Step 2. Bring all the orientations to unit stereographic triangle
[Data] = unitstereotri(Data,nodata);
disp('unitstereotri completed!')

% Step 3. Generate mesh
[Mesh]=generatemesh(Data,ss);
disp('generatemesh completed!')

% Step 4. Create additional nodes at the grain boundaries
[MeshGB]=gbmesh(Mesh,Data);
disp('gbmesh completed!')

% Step 5. Apply the FE analysis to smooth the orientation field
[uvwth,dgel] = FE(MeshGB,Data,lambda);
disp('FE completed!')

% Step 6. Calculate GNDs from orientation gradients
% Initialization
[A,b,t,alpha_vec]=initializeGND(dgel,nodata);
disp('initializeGND completed!')

% Option-1. L2 method (Arsenlis et al. 2001) 
[GND_L2] = L2_GND(nodata,alpha_vec,Burger,SF);
disp('L2_GND completed!')

% Option-2. Energy minimization method (Demir et al. 2009)
[GND_EM]=EM_GND(A,b,alpha_vec,nodata,Burger,SF);
disp('EM_GND completed!')

% Step 7. Output the results: norm of GND densities
output(Data,Mesh,GND_EM,GND_L2);
disp('output completed!')
