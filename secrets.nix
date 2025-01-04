let
  user1 = "age1reu2gg5m7qmre3a7xeytdlqrt6gdexl8sffkpwselpfl3tcxu46s6zyax5";
  systems = [user1];
in {
  "secrets/aiservice.age".publicKeys = systems;
}
