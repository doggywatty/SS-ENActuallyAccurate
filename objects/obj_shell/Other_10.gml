// feather disable all
// feather ignore all
/// @description Initialize Native Scripts

/*
 * Display help output.
 */
variable_global_set("sh_help", function(args) {
	if (array_length(args) > 1) {
		// Display specific help for an individual function
		var help_function = args[1];
		if (_array_contains(allFunctions, help_function)) {
			if (variable_struct_exists(functionData, help_function)) {
				var metadata = functionData[$ help_function];
				var output = help_function;
				if (variable_struct_exists(metadata, "arguments")) {
					for (var i = 0; i < array_length(metadata.arguments); i++) {
						output += " " + metadata.arguments[i];
					}
				}
				if (variable_struct_exists(metadata, "description")) {
					output += " - " + metadata.description;
				}
				output += "\n";
				if (variable_struct_exists(metadata, "argumentDescriptions")) {
					for (var i = 0; i < array_length(metadata.argumentDescriptions); i++) {
						var arg_name = metadata.arguments[i];
						var desc = metadata.argumentDescriptions[i];
						output += arg_name +  " - " + desc + "\n";
					}
				}
				return output;
			} else {
				return help_function + "\nNo additional information present.";
			}
		} else {
			return "No command [" + help_function + "] exists.";
		}
	} else {
		// Show a listing of all available functions
		var output = "List of available commands:\n";
		var hidden_count = 0;
		for (var i = 0; i < array_length(availableFunctions); i++) {
			var function_name = availableFunctions[i];
			// #32 : don't display hidden functions in the function list
			var hidden = false;
			var metadata = functionData[$ function_name];
			if (!is_undefined(metadata)) {
				if (variable_struct_exists(metadata, "hidden")) {
					hidden = metadata.hidden;
					hidden_count++;
				}
			}
			if (!hidden) {
				var terminator = "";
				if ((i - hidden_count) % 2 == 0) {
					var padding_width = (width/2) - (anchorMargin + string_width(function_name));
					var space_count = padding_width/string_width(" ");
					repeat (space_count) {
						terminator += " ";
					}
				} else {
					terminator = "\n";
				}
				output += function_name + terminator;
			}
		}
		return output;
	}
});
variable_global_set("meta_help", function() {
	return {
		arguments: ["<command name>"],
		suggestions: [ availableFunctions ],
		description: "Display available commands.",
		argumentDescriptions: [
			"Optional name of a command to display detailed help information for."
		]
	}
});

/*
 * Clear the console
 */
variable_global_set("sh_clear", function(args) {
	if (array_length(args) > 1 && string_lower(args[1]) == "all") {
		array_resize(output, 0);
		array_resize(history, 0);
		return "";
	} else {
		array_push(output, ">" + consoleString);
		draw_set_font(consoleFont);
		var new_lines_count = floor(visibleHeight / string_height(prompt));
		repeat(new_lines_count) {
			array_push(output, "\n");
		}
		return "";
	}
});
variable_global_set("meta_clear", function() {
	return {
		arguments: ["<all>"],
		suggestions: [
			["all"]
		],
		description: "Clear the console window.",
		argumentDescriptions: [
			"If provided, previous console output and command history will be deleted."
		]
	}
});

/*
 * Set the console's width
 */
variable_global_set("sh_shell_set_width", function(args) {
	if (array_length(args) > 1) {
		if (string_digits(args[1]) != "") {
			width = real(string_digits(args[1]));
		} else {
			return "Invalid argument: " + args[1] + ".";
		}
	} else {
		return "No argument provided.";
	}
});
variable_global_set("meta_shell_set_width", function() {
	return {
		description: "Set the width of the console window.",
		arguments: ["width"],
		argumentDescriptions: [
			"The desired width of the console, in pixels."
		]
	}
});

/*
 * Set the console's height
 */
variable_global_set("sh_shell_set_height", function(args) {
	if (array_length(args) > 1) {
		if (string_digits(args[1]) != "") {
			height = real(string_digits(args[1]));
		} else {
			return "Invalid argument: " + args[1] + ".";
		}
	} else {
		return "No argument provided.";
	}
});
variable_global_set("meta_shell_set_height", function() {
	return {
		description: "Set the height of the console window.",
		arguments: ["height"],
		argumentDescriptions: [
			"The desired height of the console, in pixels."
		]
	}
});

/*
 * Set the console's vertical anchor
 */
variable_global_set("sh_shell_set_anchor_v", function(args) {
	if (array_length(args) > 1) {
		var new_anchor = string_lower(args[1]);
		if (new_anchor == "top" || new_anchor == "middle" || new_anchor == "bottom") {
			screenAnchorPointV = new_anchor;
		} else {
			return "Invalid anchor point.\nPossible values: [top, middle, bottom].";
		}
	} else {
		return "No argument provided.";
	}
});
variable_global_set("meta_shell_set_anchor_v", function() {
	return {
		description: "Set the vertical anchor point of the console window.",
		arguments: ["anchor"],
		suggestions: [
			["top", "middle", "bottom"]
		],
		argumentDescriptions: [
			"The desired vertical anchor point."
		]
	}
});

/*
 * Set the console's horizontal anchor
 */
variable_global_set("sh_shell_set_anchor_h", function(args) {
	if (array_length(args) > 1) {
		var new_anchor = string_lower(args[1]);
		if (new_anchor == "left" || new_anchor == "center" || new_anchor == "right") {
			screenAnchorPointH = new_anchor;
		} else {
			return "Invalid anchor point.\nPossible values: [left, center, right].";
		}
	} else {
		return "No argument provided.";
	}
});
variable_global_set("meta_shell_set_anchor_h", function() {
	return {
		description: "Set the horizontal anchor point of the console window.",
		arguments: ["anchor"],
		suggestions: [
			["left", "center", "right"]
		],
		argumentDescriptions: [
			"The desired horizontal anchor point."
		]
	}
});