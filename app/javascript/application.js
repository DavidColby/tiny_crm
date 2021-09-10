import "./controllers"
import mrujs from "mrujs";
import CableReady from "cable_ready"
import { CableCar } from "mrujs/plugins"
import * as Turbo from "@hotwired/turbo"

window.Turbo = Turbo;

mrujs.start({
  plugins: [
    new CableCar(CableReady)
  ]
})
