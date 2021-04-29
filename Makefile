ifeq ($(OS),Windows_NT)
    SHELL := pwsh.exe
else
   SHELL := pwsh
endif
.SHELLFLAGS := -NoProfile -Command 

all: build

build: 
	./Build-Modules.ps1
%:
	./Build-Modules.ps1 -moduleName @('$*.psm1')


