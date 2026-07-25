final: prev:

let
  pkgs = import ./pkgs final prev;

in
{
  openocd-infineon = pkgs.com.github.infineon.openocd;
  openocd-nightly = pkgs.com.github.openocd-org.openocd;
  openocd-rpi = pkgs.com.github.raspberrypi.openocd;
  openocd-ti = pkgs.com.github.texasinstruments.ti-openocd;
  scopy = pkgs.com.github.analogdevicesinc.scopy;
  tmux = pkgs.com.github.tmux.tmux;
}
