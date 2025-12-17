let
  myPublicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHfyc8vLGSAWiIBWwGKjzXiQseDJvuxJAZV8DSFNovAP lizelit@Mac-2.local";
in
{
  "secrets/ai_token.age".publicKeys = [ myPublicKey ];
}
