<h1>Week 2: Manipulating and Analyzing Pixels</h1>

Experimented with manipulating and analyzing pixels to play around with color formation.

<h2>Requirements</h2>

Written in Processing 4.3

Video library collection required, PImage 

<h2>Operation</h2>
Learnt how to use lerpcolor, importance of documentation using Github, image/video upload 

<h2>Weekly Task</h2>
In the histogram sketch is a processing script that converts a photo to black and white, and shows a histogram of brightness. Your task is to revert the code so that it shows the image in its original colour, and then show three histograms: one each for the red, green, and blue channels of the image. It doesn't matter where you place the histograms on the screen for now. They just need to be visible. Try the sketch with your own images, too. Stretch goal: can you combine the color swap sketch with the 3 histogram to analyse the difference when you swap the colors.

<h2>Screengrabs</h2>
static only, no video necessary 

<h4>Color Channel Swap</h4>

Played around with RGB color assignments, which caused the color manipulation. 

<img width="508" alt="Screenshot 2025-02-25 at 14 26 00" src="https://github.com/user-attachments/assets/c25fc711-07e2-4eb1-9451-14fb3b1b4ec7" />

<img width="510" alt="Screenshot 2025-02-25 at 14 27 30" src="https://github.com/user-attachments/assets/f24b96f1-4029-4ae2-962c-fe06ab918c55" />


<h4>Histogram</h4>

<img width="509" alt="Screenshot 2025-02-25 at 14 28 30" src="https://github.com/user-attachments/assets/0d056c2b-43d7-462d-8363-04bafc95ca30" />

<h4>Group Task: Half Half</h4>

<h5>Original Image</h5>

![halfhalf](https://github.com/user-attachments/assets/e629f581-86b7-4b9e-98ae-28b77e1c0725)

<h5>Half Half image</h5>

<img width="574" alt="Screenshot 2025-02-25 at 14 17 26" src="https://github.com/user-attachments/assets/2169c836-a37c-42f1-98f9-f659219b6816" />

<h2>Design Note</h2>
Struggled with organising the image files with corresponding folders, in order for the image to be successfully uploaded to the code file. Realised that organisation is vital, the files need to be able to read and locate all the necessary files (such as images, videos and sounds) in the coorect corresponding folders in order for the code to work. For instance the image file has to be in the same folder that the corresponding code is located in, in order to work. Multiply coordinates by pixels to create gradient. Used dist() to find two points between coordinates to implement gradient visual. 

Struggled when inputing my own image into histogram code: image appears twice and smaller in top of frame, despite adjusting frame size to original image size. Need to fix design in code. Fixed by making halfing the dimensions of the image size in the code frame size. 
