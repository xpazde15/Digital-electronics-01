# Lab 10-13: Ultrasonic ranging module

#### Contents

1. [Introduction](#Introduction)
2. [Hardware description](#Hardware-description)
3. [Code description](#Code-description)
4. [Screenshots](#Screenshots)
5. [References](#References)


## Introduction

Cílem projektu je funkčně zapojit a naprogramovat [HC-SR04 module](#HC-SR04-module) na Coolrunner II CPLD board. 

## Hardware description

Jde o ultrazvukový měřič vzdálenosti, který využívá vyslání 40kHz pulzu z reproduktorů a jeho odraz přijme piezo mikrofonem. Dobu mezi vysláním a odrazem lze pak zpracovat a přepočítat na vzdálenost.

## Code description

Jako vstupy budeme používat clock (clk_i), reset (srst_n_i) a signál, který zpracuje dobu mezi vysláním a odrazem jako pulz, jehož šířku přepočítá na reálnou vzdálenost mezi modulem a překážkou v cm (echo_i; vzdalenost). K tomu slouží část kódu "mereni_pulzu.vhd". Šířka pulzu se určí jako vzdálenost mezi rising a falling edge pulzu (s_pulz), což zajišťuje "op.vhd" (jako "operace").

Promítání dekadických cifer na display z binárních hodnot zařizuje "hex_to_7seg.vhd" společně s příslušnými display drivery.

## Screenshots
INs a OUTs TOP modulu
<img src="Images/111.png"/>

VNITŘNÍ STRUKTURA TOP
<img src="Images/222.png"/>

PRŮBĚH TESTBENCHE
<img src="Images/333.png"/>

## References

https://github.com/tomas-fryza/Digital-electronics-1/wiki
https://allaboutfpga.com/vhdl-code-for-binary-to-bcd-converter/

