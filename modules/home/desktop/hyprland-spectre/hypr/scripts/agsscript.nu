#!/usr/bin/env nu

if (ps -l | any {|x| "ags-wrapped" in $x.command}) {
	ags -q
} else {
	ags
}
