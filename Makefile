FLOW_FILES = $(shell find ./P5REssentials/CPK -type f -name '*.flow')
BF_FILES = $(patsubst %.flow, %.BF, $(FLOW_FILES))
TARGET_DIR = "build/p5rpc.cheat.easierokumura"
SCRIPT_COMPILER = wine AtlusScriptToolchain/AtlusScriptCompiler.exe
SCRIPT_COMPILER_ARGS = -Library P5R -OutFormat V3BE

build: $(BF_FILES)
	mkdir -p $(TARGET_DIR)
	cp ModConfig.json $(TARGET_DIR)
	cp easierokumura.png $(TARGET_DIR)
	cp -r P5REssentials $(TARGET_DIR)
	find $(TARGET_DIR) -type f -name '*.flow' -delete

%.BF: %.flow
	$(SCRIPT_COMPILER) $(SCRIPT_COMPILER_ARGS) -In "$<" -Out "$@"

.PHONY: clean
clean:
	rm -rf $(TARGET_DIR)
	rm -f $(BF_FILES)
