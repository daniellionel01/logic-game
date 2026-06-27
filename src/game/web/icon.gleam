import lustre/attribute.{attribute}
import lustre/element
import lustre/element/html
import lustre/element/svg

// Sourced from https://lucide.dev/icons/pause
//
pub fn pause() -> element.Element(a) {
  svg.svg(
    [
      attribute("stroke-linejoin", "round"),
      attribute("stroke-linecap", "round"),
      attribute("stroke-width", "2"),
      attribute("stroke", "currentColor"),
      attribute("fill", "none"),
      attribute("viewBox", "0 0 24 24"),
      attribute("height", "24"),
      attribute("width", "24"),
      attribute("xmlns", "http://www.w3.org/2000/svg"),
    ],
    [
      svg.rect([
        attribute("rx", "1"),
        attribute("height", "18"),
        attribute("width", "5"),
        attribute("y", "3"),
        attribute("x", "14"),
      ]),
      svg.rect([
        attribute("rx", "1"),
        attribute("height", "18"),
        attribute("width", "5"),
        attribute("y", "3"),
        attribute("x", "5"),
      ]),
    ],
  )
}

// Sourced from https://lucide.dev/icons/square
//
pub fn square() -> element.Element(a) {
  svg.svg(
    [
      attribute("stroke-linejoin", "round"),
      attribute("stroke-linecap", "round"),
      attribute("stroke-width", "2"),
      attribute("stroke", "currentColor"),
      attribute("fill", "none"),
      attribute("viewBox", "0 0 24 24"),
      attribute("height", "24"),
      attribute("width", "24"),
      attribute("xmlns", "http://www.w3.org/2000/svg"),
    ],
    [
      svg.rect([
        attribute("rx", "2"),
        attribute("y", "3"),
        attribute("x", "3"),
        attribute("height", "18"),
        attribute("width", "18"),
      ]),
    ],
  )
}

// Sourced from https://lucide.dev/icons/skip-forward
//
pub fn skip_forward() -> element.Element(a) {
  svg.svg(
    [
      attribute("stroke-linejoin", "round"),
      attribute("stroke-linecap", "round"),
      attribute("stroke-width", "2"),
      attribute("stroke", "currentColor"),
      attribute("fill", "none"),
      attribute("viewBox", "0 0 24 24"),
      attribute("height", "24"),
      attribute("width", "24"),
      attribute("xmlns", "http://www.w3.org/2000/svg"),
    ],
    [
      svg.path([attribute("d", "M21 4v16")]),
      svg.path([
        attribute(
          "d",
          "M6.029 4.285A2 2 0 0 0 3 6v12a2 2 0 0 0 3.029 1.715l9.997-5.998a2 2 0 0 0 .003-3.432z",
        ),
      ]),
    ],
  )
}

// Sourced from https://lucide.dev/icons/play
//
pub fn play() -> element.Element(a) {
  svg.svg(
    [
      attribute("stroke-linejoin", "round"),
      attribute("stroke-linecap", "round"),
      attribute("stroke-width", "2"),
      attribute("stroke", "currentColor"),
      attribute("fill", "none"),
      attribute("viewBox", "0 0 24 24"),
      attribute("height", "24"),
      attribute("width", "24"),
      attribute("xmlns", "http://www.w3.org/2000/svg"),
    ],
    [
      svg.path([
        attribute(
          "d",
          "M5 5a2 2 0 0 1 3.008-1.728l11.997 6.998a2 2 0 0 1 .003 3.458l-12 7A2 2 0 0 1 5 19z",
        ),
      ]),
    ],
  )
}

// Sourced from https://lucide.dev/icons/eraser
//
pub fn eraser() -> element.Element(a) {
  svg.svg(
    [
      attribute("stroke-linejoin", "round"),
      attribute("stroke-linecap", "round"),
      attribute("stroke-width", "2"),
      attribute("stroke", "currentColor"),
      attribute("fill", "none"),
      attribute("viewBox", "0 0 24 24"),
      attribute("height", "24"),
      attribute("width", "24"),
      attribute("xmlns", "http://www.w3.org/2000/svg"),
    ],
    [
      svg.path([
        attribute(
          "d",
          "M21 21H8a2 2 0 0 1-1.42-.587l-3.994-3.999a2 2 0 0 1 0-2.828l10-10a2 2 0 0 1 2.829 0l5.999 6a2 2 0 0 1 0 2.828L12.834 21",
        ),
      ]),
      svg.path([attribute("d", "m5.082 11.09 8.828 8.828")]),
    ],
  )
}

// Sourced from https://lucide.dev/icons/painter-roller
//
pub fn paint_roller() -> element.Element(a) {
  svg.svg(
    [
      attribute("stroke-linejoin", "round"),
      attribute("stroke-linecap", "round"),
      attribute("stroke-width", "2"),
      attribute("stroke", "currentColor"),
      attribute("fill", "none"),
      attribute("viewBox", "0 0 24 24"),
      attribute("height", "24"),
      attribute("width", "24"),
      attribute("xmlns", "http://www.w3.org/2000/svg"),
    ],
    [
      svg.rect([
        attribute("rx", "2"),
        attribute("y", "2"),
        attribute("x", "2"),
        attribute("height", "6"),
        attribute("width", "16"),
      ]),
      svg.path([
        attribute(
          "d",
          "M10 16v-2a2 2 0 0 1 2-2h8a2 2 0 0 0 2-2V7a2 2 0 0 0-2-2h-2",
        ),
      ]),
      svg.rect([
        attribute("rx", "1"),
        attribute("y", "16"),
        attribute("x", "8"),
        attribute("height", "6"),
        attribute("width", "4"),
      ]),
    ],
  )
}

// Sourced from https://lucide.dev/icons/rotate-ccw
//
pub fn rotate_ccw() -> element.Element(a) {
  svg.svg(
    [
      attribute("stroke-linejoin", "round"),
      attribute("stroke-linecap", "round"),
      attribute("stroke-width", "2"),
      attribute("stroke", "currentColor"),
      attribute("fill", "none"),
      attribute("viewBox", "0 0 24 24"),
      attribute("height", "24"),
      attribute("width", "24"),
      attribute("xmlns", "http://www.w3.org/2000/svg"),
    ],
    [
      svg.path([
        attribute("d", "M3 12a9 9 0 1 0 9-9 9.75 9.75 0 0 0-6.74 2.74L3 8"),
      ]),
      svg.path([attribute("d", "M3 3v5h5")]),
    ],
  )
}

// Sourced from https://lucide.dev/icons/rotate-cw
//
pub fn rotate_cw() -> element.Element(a) {
  svg.svg(
    [
      attribute("stroke-linejoin", "round"),
      attribute("stroke-linecap", "round"),
      attribute("stroke-width", "2"),
      attribute("stroke", "currentColor"),
      attribute("fill", "none"),
      attribute("viewBox", "0 0 24 24"),
      attribute("height", "24"),
      attribute("width", "24"),
      attribute("xmlns", "http://www.w3.org/2000/svg"),
    ],
    [
      svg.path([
        attribute("d", "M21 12a9 9 0 1 1-9-9c2.52 0 4.93 1 6.74 2.74L21 8"),
      ]),
      svg.path([attribute("d", "M21 3v5h-5")]),
    ],
  )
}

// Sourced from https://lucide.dev/icons/arrow-up
//
pub fn arrow_up() -> element.Element(a) {
  svg.svg(
    [
      attribute("stroke-linejoin", "round"),
      attribute("stroke-linecap", "round"),
      attribute("stroke-width", "2"),
      attribute("stroke", "currentColor"),
      attribute("fill", "none"),
      attribute("viewBox", "0 0 24 24"),
      attribute("height", "24"),
      attribute("width", "24"),
      attribute("xmlns", "http://www.w3.org/2000/svg"),
    ],
    [
      svg.path([attribute("d", "m5 12 7-7 7 7")]),
      svg.path([attribute("d", "M12 19V5")]),
    ],
  )
}

// Sourced from https://lucide.dev/icons/star
//
pub fn star() -> element.Element(a) {
  svg.svg(
    [
      attribute("stroke-linejoin", "round"),
      attribute("stroke-linecap", "round"),
      attribute("stroke-width", "2"),
      attribute("stroke", "currentColor"),
      attribute("fill", "currentColor"),
      attribute("viewBox", "0 0 24 24"),
      attribute("height", "24"),
      attribute("width", "24"),
      attribute("xmlns", "http://www.w3.org/2000/svg"),
    ],
    [
      svg.path([
        attribute(
          "d",
          "M11.525 2.295a.53.53 0 0 1 .95 0l2.31 4.679a2.123 2.123 0 0 0 1.595 1.16l5.166.756a.53.53 0 0 1 .294.904l-3.736 3.638a2.123 2.123 0 0 0-.611 1.878l.882 5.14a.53.53 0 0 1-.771.56l-4.618-2.428a2.122 2.122 0 0 0-1.973 0L6.396 21.01a.53.53 0 0 1-.77-.56l.881-5.139a2.122 2.122 0 0 0-.611-1.879L2.16 9.795a.53.53 0 0 1 .294-.906l5.165-.755a2.122 2.122 0 0 0 1.597-1.16z",
        ),
      ]),
    ],
  )
}

pub fn train() -> element.Element(a) {
  svg.svg(
    [
      attribute("overflow", "visible"),
      attribute("viewBox", "-4 -2 124.5 58.4"),
      attribute("xmlns", "http://www.w3.org/2000/svg"),
    ],
    [
      element.element("style", [attribute.type_("text/css")], [
        html.text(
          ".cls-0 {fill:#EDEDEE;}
  .cls-1 {fill:#FFFFFF;}
  .cls-2 {fill:#A7A8AA;}
  .cls-3 {fill:#434548;}",
        ),
      ]),
      svg.path([
        attribute(
          "d",
          "m96.1 0h-83.8c-4.8 1.4-9.1 4.6-12.3 8.2v37c2.9 3.9 6.9 7.1 12.3 9l1.5 0.5h84c-2.6-0.7 10.2-2.5 18.7-6.7v-41.9c-4.8-2.3-12-4.8-20.4-6.1z",
        ),
        attribute.class("cls-1"),
      ]),
      svg.path([
        attribute(
          "d",
          "m18.2 2.3c-6.2-0.7-12.9 3.3-16.2 8.8-0.5 0.8-1 2.2 0.2 2.2h8.5c1.2 0 2.1-0.8 2.8-1.7l5.8-6.9c0.6-0.5 0.6-2.3-1.1-2.4z",
        ),
        attribute.class("cls-2"),
      ]),
      svg.path([
        attribute(
          "d",
          "m2.2 40.6c-1 0-1.2 0.7-0.6 1.7 2.6 4.4 9 9.5 15.8 9.5 2.1 0 2.8-0.6 2.1-2.2l-6.3-7.6c-0.2-0.4-1.3-1.4-3-1.4h-8z",
        ),
        attribute.class("cls-2"),
      ]),
      svg.path([
        attribute(
          "d",
          "m43.1 1.1h-10.6c-0.9 0-1.9 0.6-1.9 1.6s0.6 1.9 1.7 1.9h10.6c1 0 1.9-0.6 1.9-1.8s-0.9-1.7-1.7-1.7z",
        ),
        attribute.class("cls-2"),
      ]),
      svg.path([
        attribute(
          "d",
          "m60.5 1h-9.9c-0.8 0-1.8 0.5-1.8 1.7s0.7 1.9 1.7 1.9h10.2c0.9 0 1.7-0.7 1.7-1.8s-0.8-1.8-1.9-1.8z",
        ),
        attribute.class("cls-2"),
      ]),
      svg.path([
        attribute(
          "d",
          "m78.6 1h-10.1c-1 0-1.9 0.5-1.9 1.7s0.9 1.8 1.6 1.8h10.4c1 0 1.9-0.6 1.9-1.8 0-1.1-0.9-1.7-1.9-1.7z",
        ),
        attribute.class("cls-2"),
      ]),
      svg.path([
        attribute(
          "d",
          "m43 49.3h-10.4c-1 0-2 0.5-2 1.9 0 0.8 0.8 1.8 1.8 1.9h10.6c1 0 1.8-0.7 1.7-1.9 0-0.9-0.8-1.9-1.7-1.9z",
        ),
        attribute.class("cls-2"),
      ]),
      svg.path([
        attribute(
          "d",
          "m60.5 49.3h-9.9c-0.8 0-1.8 0.3-1.8 1.8 0 1.2 0.8 2 1.8 2h9.9c1 0.1 1.9-0.7 1.9-1.9s-0.9-1.9-1.9-1.9z",
        ),
        attribute.class("cls-2"),
      ]),
      svg.path([
        attribute(
          "d",
          "m78.6 49.3h-10.3c-0.8 0-1.7 0.7-1.7 1.8 0 1.3 0.9 2 1.7 2h10.3c1 0.1 1.9-0.7 1.9-1.9 0-1.1-0.9-1.9-1.9-1.9z",
        ),
        attribute.class("cls-2"),
      ]),
      svg.path([
        attribute(
          "d",
          "m89.9 8.8c-1.5 0.1-2.5 0.8-2.1 1.9 2 1.7 3 8.2 3 16.6 0 6.8-0.9 13.7-2.7 15.7-0.6 0.6-0.3 2 2 2 4-0.3 14.3-1.8 19.1-5 4.4-2.7 6-7.2 6-12.5 0-10.9-6.7-16.8-25.3-18.7z",
        ),
        attribute.class("cls-3"),
      ]),
    ],
  )
}
