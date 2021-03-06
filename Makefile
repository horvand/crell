ERL					?= erl
ERLC				= erlc
EBIN_DIRS		:= $(wildcard deps/*/ebin)
APPS				:= $(shell dir apps)
REL_DIR     = rel
NODE				= crell
REL					= crell
SCRIPT_PATH  := $(REL_DIR)/$(NODE)/bin/$(REL)

.PHONY: rel offline compile get-deps update-deps test clean deep-clean

rel: compile
	@rebar generate -f
	@cd deps/grapherl/ ; rebar escriptize

offline:
	@rebar compile
	@rebar generate

compile: get-deps update-deps
	@rebar compile

beams:
	@rebar compile

get-deps:
	@rebar get-deps

update-deps:
	@rebar update-deps

test: offline
	@rebar skip_deps=true apps="loom" eunit

clean:
	@rebar clean

deep-clean: clean
	@rebar delete-deps

setup_dialyzer:
	dialyzer --build_plt --apps erts kernel stdlib mnesia compiler syntax_tools runtime_tools crypto tools inets ssl webtool public_key observer
	dialyzer --add_to_plt deps/*/ebin

dialyzer: compile
	dialyzer */apps/*/ebin

doc:
	rebar skip_deps=true doc
	for app in $(APPS); do \
		cp -R apps/$${app}/doc doc/$${app}; \
	done;

analyze: checkplt
	@rebar skip_deps=true dialyze

buildplt:
	@rebar skip_deps=true build-plt

checkplt: buildplt
	@rebar skip_deps=true check-plt