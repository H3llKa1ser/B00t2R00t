# Veil Evasion

The Veil Framework is a collection of red team tools, focused on evading detection. The Veil Evasion project is a tool to generate artifacts that get past anti-virus. It’s worth getting to know Veil. It has a lot of capability built into it.

Cobalt Strike 2.0’s Payload Generator includes an option to output a Cobalt Strike payload in a format that’s Veil-ready. Go to Attacks -> Packages -> Payload Generator to open it. Choose your listener and set veil as the output type. Save the file it generates.

<img width="417" height="286" alt="image" src="https://github.com/user-attachments/assets/1fc0beb8-685f-4738-83dd-dfccdfd74a6f" />

Now, go to Veil and choose the type of artifact you want to create. Veil will ask if you want to use msfvenom or supply your own shellcode. Select the option to supply your own shellcode. Paste in the contents of the veil file made by Cobalt Strike. Congratulations–you have made a Veil artifact with a Cobalt Strike payload.

<img width="811" height="303" alt="image" src="https://github.com/user-attachments/assets/da2c7c22-afe1-463b-91cd-06c72fdd0f09" />

Links:

1) https://github.com/Veil-Framework/Veil-Evasion/blob/master/tools/cortana/veil_evasion.cna

2) https://www.cobaltstrike.com/blog/use-cobalt-strikes-beacon-with-veils-evasion/
