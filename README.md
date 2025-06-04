<h1>Computational Practises: Sound & Image Processing</h1>

**Year 1, Spring Term 2025, Processing Software (Java coding language)**

<h2>Weekly topics & Tasks</h2>

<h3>Week-01: Pixels and Colour</h3>

Experiment with the code in examples/gradient: add more colors into the gradient, change it’s direction, make a circular gradient centred on the middle of the screen

<h3>Week-02: Manipulating and Analyzing Pixels</h3>

In the histogram sketch is a processing script that converts a photo to black and white, and shows a histogram of brightness. Your task is to revert the code so that it shows the image in its original colour, and then show three histograms: one each for the red, green, and blue channels of the image.
It doesn't matter where you place the histograms on the screen for now. They just need to be visible. Try the sketch with your own images, too.
Stretch goal: can you combine the color swap sketch with the 3 histogram to analyse the difference when you swap the colors.

<h3>Week-03: Vector Graphics</h3>

In this task, you will use the random() function in Processing to create a grid of circles arranged in a chequerboard pattern. Each circle will either have a random shade of color or a fixed color, alternating across the grid.

Hints: Use random() to generate random values for colors (check the Processing reference). For the chequerboard pattern, modulo can help you alternate between two sets of values, ensuring the correct placement of random and fixed color circles.

<h3>Week-04: Filtering Images</h3>

Generate a 2D landscape using Perlin Noise and apply a duotone color effect based on the terrain heights. The goal is to understand how to blend two colors smoothly based on the terrain values, creating a visually interesting landscape with dynamic color transitions.

Sketch Goals: how might you use noise to animate the terrain.

<h3>Week-05: Convolution and Dithering</h3>

In this task, you will implement a real-time image processing system using your webcam. Combine a dithering algorithm with one of the filters we looked at last week. The processed image should update continuously as the webcam feed changes, showing both the dithering effect and the selected filter. Use the saveFrame function to make a story reel of up to 10 pictures like in a comic book.

<h3>Week-06: Digital Sound</h3>

(Required minimum) Using at least 3 oscillators and/or filters, try to design a sound for a sci-fi movie, when the main characters arrive onto a new planet.

Frequency modulation - alternate the frequency over time
Code example
Feel free to add filters if you want to.
More about sound filters.
Filter demo code

<h3>Week-07: Synthesizing Sound</h3>

Using at least 4 samples, create a drum pattern. Make the pattern change in time. You could do that by:
    - adding an element of randomness to at least one of the samples,
    - alternate the pattern depending on time, e.g. count bars based on frameCount, seconds or milliseconds

How to start (optional prompts):

- Pick some samples from the resources below (or find or record your own), and modify the example from class using them.
- Pick a drum pattern or a beat from a song from the examples below (or your own example), and try to replicate it. If you're a beginner, replicating one of these would be a good start: Essential drum patterns (for hip hop).
- Design your own beat using clapping, visuals, or however you like, and try to replicate it.

(Optional). Can you add an audio-reactive visualisation? For this, you may want to increase the frameRate to achieve a smooth animation. For example, if you want the music to play at 120 bpm, which is 2 times per second, set the frameRate to 60 and play the base sound every 30th frame (frameCount % 30 == 0).
(Advanced). Can you combine sound synthesised with an oscillator (task from last week) with looped samples in a single piece of music?

<h3>Week-08: Motion, Vectors, Forces</h3>

Hackathon, no task 

<h3>Week-09: Particles, Systems</h3>

Make a game using all of the below:
- at least 1 class
- at least 2 forces influencing the object movement
- at least 1 type of interaction.

Feel free to use the prompts below or use your own idea. You can also start with a sketch you developed earlier in the term - make sure to save it as a new sketch, as these are separate tasks to submit!

Think about:

the theme of the game
what types of objects / game characters you might need
the goal of the game
the score (if there is one)
how does the game end?
what are the interactions?

Optional prompts:

You're a player running away from a giant space worm.
You're a zombie and you need to collect brains to survive.
You're a unicorn jumping from one rainbow to another.
You collect flowers of different kinds to complete a predefined bouquet.

<h3>Week-10: Simulation & Behaviour</h3>

Create an interactive sketch implementing Particle Systems and Array Lists.

The sketch should have:
at least 3 vectors (PVector) for each particle: location, velocity, acceleration,
at least one type of user interaction impacting the system,
at least 1 randomised force impacting the system (e.g. wind).

Feel free to use the optional prompts below:
Petals falling from blossom tress,
Leaves falling in the autumn,
Snow,
Cosmic explosion, cosmic dust or falling stars,
Sea creatures such as plankton.

Please note as particles are points, you can use a graphic asset or a custom drawing for display if you want to.






