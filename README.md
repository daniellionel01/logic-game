# Logic Game

Based on the second logic game that you have to play if you register for the coding camp at [42heilbronn](https://www.42heilbronn.de).
My time ran out on a level so I decided to program this game myself and keep working on the level.

The files, and parts of this readme file, are based on the [vite vue-ts](https://github.com/vitejs/vite/tree/main/packages/create-vite/template-vue-ts) template.

This repo is hosted on Vercel at [https://logic-game.vercel.app/](https://logic-game.vercel.app/)

## Functional Todos
- [x] won / lost states
- [x] help dialog
- [x] select level
- [x] paint color instruction
- [x] setup vercel
- [x] step control button
- [ ] limit execution stack

## Cleaner Code Todos
- [ ] get ship cell utility
- [ ] is star utility
- [ ] is star select utility
- [ ] compare positions (star / cell / ship) utility

## Extra Todos
- [ ] use q/w/e/... to select action and
      enter to confirm current selected instruction
- [x] backspace to delete selected instruction
- [x] make empty instruction width 3
- [ ] make actions a tooltip of selected instruction
- [ ] clear local storage button
- [x] incr / decr game clock
- [ ] better function input (dnd, move to the right immediately)
- [ ] function input shortcut (digits, shift+digit -> moves to the next one)
- [ ] better function cell color toggle
- [ ] prettier ui
- [ ] save and show completed levels

## Techstack
- TypeScript
- NodeJS
- Vite
- SolidJS
- TailwindCSS
- DaisyUI

## Third Party Licenses
- Font Awesome: https://fontawesome.com/license (no changes were made to the icons)
