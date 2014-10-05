NyimboZaKristo IOS Application.

This an application that allows users to view christian hymns from their church book, they can either search using song title or song number. If the song they are seeing has an audio clip or video clip they can play and get to learn the song.
It used a web backend located at 107.170.159.133:8080/NyimboZaKristo. 

 IOS Deployment Target 4.3
 
 To get the code and compile you need to click on the project Target, Build Phase and expand on compile sources
 the following files you need to add -fno-obj-arc
 TPKeyBoardAvoidingScrollView.m, JSONKit.m CustomKeyboard.m, UIScrollView+TPKeyboardAvoidingAdditions.m HTTPFetcher.m AsyncHTTPClient.m
 
 The reason why you need to add the flag is because i have used ARC for memmory management and the authors of the file wrote for non ARC enviroment.
 
