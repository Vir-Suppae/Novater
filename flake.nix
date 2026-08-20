{
  description = "Novater dev flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = inputs: {
    devShells = builtins.mapAttrs (system: pkgs: {
      default = pkgs.mkShell {
        packages = with pkgs; [
          zig_0_16
          zls_0_16
        ];

        buildInputs = with pkgs; [
          wayland
          wayland-scanner
          wayland-protocols
          libxkbcommon
          libGL
        ];
      };
    }) inputs.nixpkgs.legacyPackages;
  };
}
