stage {
set userwx "false";
set compile_time "14 Jul 2009 8:14:00";
set image_size_x86 "512000";
set image_size_x64 "512000";
set obfuscate "true";
transform-x86 {
prepend "\x90\x90";
strrep "ReflectiveLoader" "DoLegitStuff";
}
transform-x64 {
#comment transform the x64 rDLL stage
}
stringw "I am not Beacon";
}
