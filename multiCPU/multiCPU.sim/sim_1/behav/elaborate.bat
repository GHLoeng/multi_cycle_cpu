@echo off
set xv_path=E:\\Xilinx2015.4\\Vivado\\2015.4\\bin
call %xv_path%/xelab  -wto 14f61a2bed71481c8984a7da5c6c677f -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot CPU_sim_behav xil_defaultlib.CPU_sim xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
