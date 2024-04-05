# Standard stuff

.SUFFIXES:

MAKEFLAGS+= --no-builtin-rules
MAKEFLAGS+= --warn-undefined-variables

export hostSystemName=$(shell uname)

.PHONY: all coverage check test clean distclean
all: .init coverage test

coverage:
	cmake --workflow --preset dev
	gcovr .

check:
	-iwyu_tool.py -p build/coverage source \
		-- -Xiwyu --cxx17ns #XXX -Xiwyu --transitive_includes_only
	run-clang-tidy -p build/coverage -checks='-*,misc-header-*,misc-include-*' source
	ninja -C build/coverage format-check
	ninja -C build/coverage format-check

test:
	cmake --preset ci-${hostSystemName}
	cmake --build build
	cmake --install build --prefix $(CURDIR)/stagedir
	cmake -G Ninja -B build/tests -S test -D CMAKE_PREFIX_PATH=$(CURDIR)/stagedir
	cmake --build build/tests
	ctest --test-dir build/tests

.init: requirements.txt .CMakeUserPresets.json
	perl -p -e 's/<hostSystemName>/${hostSystemName}/g;' .CMakeUserPresets.json > CMakeUserPresets.json
	-pip3 install --user --upgrade -r requirements.txt
	touch .init

clean:
	rm -rf build

distclean: clean
	rm -rf stagedir .init tags *.bak

GNUmakefile :: ;
*.txt :: ;
*.json :: ;

# Anything we don't know how to build will use this rule.
# The command is a do-nothing command.
#
% :: ;
