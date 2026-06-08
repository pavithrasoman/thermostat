# Toolchain
CC = arm-none-eabi-gcc
AS = arm-none-eabi-as
OBJCOPY = arm-none-eabi-objcopy
SIZE = arm-none-eabi-size

# MCU and compiler flags
MCU = cortex-m4
CFLAGS = -mcpu=$(MCU) -mthumb -O0 -g3 -Wall
CFLAGS += $(addprefix -I,$(INC_DIRS))
CFLAGS += -DSTM32F446xx

# Linker flags
LDFLAGS = -mcpu=$(MCU) -mthumb
LDFLAGS += -specs=nosys.specs
LDFLAGS += -T STM32F446XX_FLASH.ld
LDFLAGS += -Wl,-Map=build/output.map
LDFLAGS += -Wl,--gc-sections

# Build directory
BUILD_DIR = build

# Source files (where .c and .s files are)
C_SOURCES = Core/Src/system_stm32f4xx.c myDriver/main.c myDriver/gpio.c myDriver/systick.c
ASM_SOURCES = startup_stm32f446xx.s

# Include directories (where .h files are)
INC_DIRS = myDriver Drivers/CMSIS/Device/ST/STM32F4xx/Include Drivers/CMSIS/Include

# Object files
OBJECTS = $(addprefix $(BUILD_DIR)/,$(notdir $(C_SOURCES:.c=.o)))
OBJECTS += $(addprefix $(BUILD_DIR)/,$(notdir $(ASM_SOURCES:.s=.o)))

# Target
TARGET = $(BUILD_DIR)/gpio_blink

# Default target: build everything
all: $(BUILD_DIR) $(TARGET).elf
	@echo "Build complete!"
	$(SIZE) $(TARGET).elf

# Create build directory
$(BUILD_DIR):
	if not exist $(BUILD_DIR) mkdir $(BUILD_DIR)

# Tell Make where to find source files
vpath %.c Core/Src/system_stm32f4xx.c myDriver
vpath %.s .

# Link object files into .elf
$(TARGET).elf: $(OBJECTS)
	$(CC) $(OBJECTS) $(LDFLAGS) -o $@

# compile C file to object file
$(BUILD_DIR)/main.o: myDriver/main.c
	$(CC) -c $< -o $@ $(CFLAGS)

$(BUILD_DIR)/gpio.o: myDriver/gpio.c
	$(CC) -c $< -o $@ $(CFLAGS)

$(BUILD_DIR)/systick.o: myDriver/systick.c
$(BUILD_DIR)/system_stm32f4xx.o: Core/Src/system_stm32f4xx.c
	$(CC) -c $< -o $@ $(CFLAGS)

$(BUILD_DIR)/startup_stm32f446xx.o: startup_stm32f446xx.s
	$(AS) $< -o $@ -mcpu=$(MCU) -mthumb -g 

# Phony targets
.PHONY: all clean flash

# Clean build artifacts
clean:
	if exist $(BUILD_DIR) rmdir /s /q $(BUILD_DIR)

# Flash to microcontroller
flash: $(TARGET).elf
	C:\xpack-openocd-0.12.0-7\bin\openocd.exe -f interface/stlink.cfg -f target/stm32f4x.cfg -c "program $(TARGET).elf verify reset exit"

