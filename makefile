TARGET = worldwide

ifeq ($(OS),Windows_NT)
    TARGET = worldwide.exe
endif

.PHONY: all
all:
	go build -o $(TARGET) -ldflags "-X main.version=$(shell git describe --tags)" ./cmd/

.PHONY: run
run:
	make all
ifeq ($(DEBUG), on)
	$(eval DEBUG_FLAG = --debug)
endif
	./$(TARGET) $(DEBUG_FLAG) ${ROM}

.PHONY: clean
clean:
	rm -f $(TARGET)

.PHONY: test

TEST0=gb-test-roms/cpu_instrs/
TEST1=gb-test-roms/instr_timing/
TEST2=mooneye-gb/add_sp_e_timing/
TEST3=mooneye-gb/call_cc_timing/
TEST4=mooneye-gb/div_timing/
TEST5=mooneye-gb/instr/daa/
TEST6=mooneye-gb/intr_timing/
TEST7=mooneye-gb/jp_timing/
TEST8=mooneye-gb/ld_hl_sp_e_timing/
TEST9=mooneye-gb/oam_dma/basic/
TEST10=mooneye-gb/oam_dma/reg_read/
TEST11=mooneye-gb/instr/daa/
TEST12=mooneye-gb/ld_hl_sp_e_timing/
TEST13=mooneye-gb/intr_timing/
TEST14=mooneye-gb/oam_dma_restart/
TEST15=mooneye-gb/call_cc_timing2/
TEST16=mooneye-gb/call_timing2/
TEST17=mooneye-gb/ei_sequence/
TEST18=mooneye-gb/ei_timing/
TEST19=mooneye-gb/if_ie_registers/
TEST20=mooneye-gb/pop_timing/
TEST21=mooneye-gb/rapid_di_ei/
TEST22=mooneye-gb/halt_ime0_ei/
TEST23=mooneye-gb/halt_ime1_timing/

TIM_TEST0=mooneye-gb/timer/div_write/
TIM_TEST2=mooneye-gb/timer/tim00/
TIM_TEST4=mooneye-gb/timer/tim01/
TIM_TEST6=mooneye-gb/timer/tim10/
TIM_TEST8=mooneye-gb/timer/tim11/
TIM_TEST9=mooneye-gb/timer/tim11_div_trigger/
TIM_TEST10=mooneye-gb/timer/tima_reload/

define compare
	go run ./cmd/ --test="./test/$1actual.jpg" ./test/$1rom.gb
	-diff "./test/$1actual.jpg" "./test/$1expected.jpg" && echo "$1 OK"
endef

.SILENT:
test:
	-$(call compare,$(TEST0))
	-$(call compare,$(TEST1))
	-$(call compare,$(TEST2))
	-$(call compare,$(TEST3))
	-$(call compare,$(TEST4))
	-$(call compare,$(TEST5))
	-$(call compare,$(TEST6))
	-$(call compare,$(TEST7))
	-$(call compare,$(TEST8))
	-$(call compare,$(TEST9))
	-$(call compare,$(TEST10))
	-$(call compare,$(TEST11))
	-$(call compare,$(TEST12))
	-$(call compare,$(TEST13))
	-$(call compare,$(TEST14))
	-$(call compare,$(TEST15))
	-$(call compare,$(TEST16))
	-$(call compare,$(TEST17))
	-$(call compare,$(TEST18))
	-$(call compare,$(TEST19))
	-$(call compare,$(TEST20))
	-$(call compare,$(TEST21))
	-$(call compare,$(TEST22))
	-$(call compare,$(TEST23))

	-rm -f ./test/$(TEST0)actual.jpg \
	./test/$(TEST1)actual.jpg \
	./test/$(TEST2)actual.jpg \
	./test/$(TEST3)actual.jpg \
	./test/$(TEST4)actual.jpg \
	./test/$(TEST5)actual.jpg \
	./test/$(TEST6)actual.jpg \
	./test/$(TEST7)actual.jpg \
	./test/$(TEST8)actual.jpg \
	./test/$(TEST9)actual.jpg \
	./test/$(TEST10)actual.jpg \
	./test/$(TEST11)actual.jpg \
	./test/$(TEST12)actual.jpg \
	./test/$(TEST13)actual.jpg \
	./test/$(TEST14)actual.jpg \
	./test/$(TEST15)actual.jpg \
	./test/$(TEST16)actual.jpg \
	./test/$(TEST17)actual.jpg \
	./test/$(TEST18)actual.jpg \
	./test/$(TEST19)actual.jpg \
	./test/$(TEST20)actual.jpg \
	./test/$(TEST21)actual.jpg \
	./test/$(TEST22)actual.jpg \
	./test/$(TEST23)actual.jpg \

.SILENT:
timer-test:
	-$(call compare,$(TIM_TEST0))
	-$(call compare,$(TIM_TEST2))
	-$(call compare,$(TIM_TEST4))
	-$(call compare,$(TIM_TEST6))
	-$(call compare,$(TIM_TEST8))
	-$(call compare,$(TIM_TEST9))
	-$(call compare,$(TIM_TEST10))

	-rm -f ./test/$(TIM_TEST0)actual.jpg \
	./test/$(TIM_TEST2)actual.jpg \
	./test/$(TIM_TEST4)actual.jpg \
	./test/$(TIM_TEST6)actual.jpg \
	./test/$(TIM_TEST8)actual.jpg \
	./test/$(TIM_TEST9)actual.jpg \
	./test/$(TIM_TEST10)actual.jpg \
