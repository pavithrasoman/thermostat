# Thermostat Firmware Project – Phase 1: Bare-metal Drivers

## Overview

This repository contains the ongoing development of a thermostat firmware project for the STM32F446RE microcontroller.

The project is being developed in multiple stages, starting with custom bare-metal peripheral drivers and progressing toward a complete thermostat application featuring sensors, user input, control logic, and RTOS-based architecture.

This first phase focuses on implementing a custom driver and establishing a complete embedded development workflow from source code to hardware execution.

## Current Progress

### GPIO Driver

* Custom GPIO driver developed using bare-metal register programming
* GPIO initialization and output control
* Onboard LED (LD2 - PA5) control

### SysTick Driver (System Timebase)
* Implemented SysTick timer using ARM Cortex-M4 core peripheral
* Configured 1 ms system tick using core clock (SystemCoreClock)
* Developed millisecond delay functionality using SysTick counter
* Provided system timebase for future drivers and application timing control
* Established foundation for RTOS scheduling and event-driven firmware architecture

### Development Environment

* STM32CubeMX project setup
* GNU ARM Embedded Toolchain
* Makefile-based build system
* OpenOCD flashing support
* Visual Studio Code development environment

### Verification

* Successfully compiled and linked firmware
* Flashed firmware to STM32 Nucleo-F446RE
* Verified GPIO functionality by blinking the onboard LED

## Technologies

* C
* ARM Cortex-M4
* STM32F446RE
* CMSIS
* GNU Arm Embedded Toolchain
* OpenOCD
* Make
* Visual Studio Code

## Roadmap

### Phase 1 – Bare-Metal Drivers (Current)

* [x] GPIO Driver
* [x] SysTick Driver (NEW)
* [ ] UART Driver
* [ ] Timer Driver
* [ ] ADC Driver
* [ ] I2C Driver
* [ ] SPI Driver

### Phase 2 – Thermostat Application

* [ ] Temperature sensing
* [ ] User configuration interface
* [ ] Heating control logic
* [ ] State machine implementation

### Phase 3 – Advanced Architecture

* [ ] Layered driver architecture
* [ ] Event-driven design
* [ ] Scheduler integration
* [ ] Error handling framework

### Phase 4 – Production-Grade Firmware

* [ ] FreeRTOS integration
* [ ] Watchdog monitoring
* [ ] Fault reporting
* [ ] MPU protection
* [ ] Unit testing
* [ ] CI/CD pipeline

## Status

🚧 Ongoing Development

Phase 1 completed: Custom GPIO and sysTick driver implemented and validated on STM32 Nucleo-F446RE.
