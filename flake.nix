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
          libGL
          libx11
          libxcursor
          libxrandr
          libxinerama
          libxi
        ];
      };
    }) inputs.nixpkgs.legacyPackages;
  };
}
