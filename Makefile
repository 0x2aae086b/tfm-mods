CAT := cat
RM := rm -f
MIN := lua ../LuaMinify-master/CommandLineMinify.lua

TEST_SRC := src/common/*.lua src/test/data.lua  src/test/interpreter.lua \
            src/test/help.lua src/test/commands.lua src/test/events.lua \
            src/test/main.lua

TEST := build/test.lua
TEST_MIN := build/test.min.lua

STG_SRC := src/common/rename.lua src/common/util.lua src/common/help.lua \
           src/common/chatcommand.lua src/common/id.lua \
           src/common/ui.lua src/common/timer.lua \
           src/stg/util.lua src/stg/enum.lua src/stg/ui.lua src/stg/step.lua \
           src/stg/callbacks.lua src/stg/addremove.lua src/stg/bullet.lua \
           src/stg/bullets.lua src/stg/bomb.lua src/stg/motion.lua \
           src/stg/motiontypes.lua src/stg/bombs.lua src/stg/pattern.lua \
           src/stg/patterns.lua src/stg/shot.lua src/stg/shots.lua \
           src/stg/player.lua src/stg/data.lua src/stg/help.lua \
           src/stg/commands.lua src/stg/events.lua src/stg/main.lua

STG := build/stg.lua
STG_MIN := build/stg.min.lua

all: $(STG) $(TEST)

allmin: $(STG_MIN) $(TEST_MIN)

clean:
	$(RM) $(STG) $(TEST) $(STG_MIN) $(TEST_MIN)

$(TEST): $(TEST_SRC)
	$(CAT) $^ >$@

$(STG): $(STG_SRC)
	$(CAT) $^ >$@

%.min.lua: %.lua
	$(MIN) $< $@
