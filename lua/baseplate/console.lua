-- type .code in your Blockland console to evaluate lua
-- ex. ".print('hello')"

ts.eval([[
package LuaConsole {
   function ConsoleEntry::eval() {
      %text = ConsoleEntry.getValue();
      if(strpos(%text, ".") != 0) {
         Parent::eval();
         return;
      }

      %text = getSubStr(%text, 1, strlen(%text) - 1);

      echo("Lua> " @ %text);
      luaEval(%text);

      ConsoleEntry.setValue("");
   }
};

activatePackage(LuaConsole);
]])
