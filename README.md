# Diwali Rocket Stability

*A simple study of why a Diwali rocket flies straight, and what its stick has to do with it*

## 1. Introduction

Every Diwali, rockets shoot up into the night sky. Each one has a long, thin stick tied to its side. It looks like a handle, but it does an important job: it keeps the rocket pointing the right way while it flies.

This paper asks one simple question: **what does the stick do, and what happens if we cut it to half its length?** To find out, we filmed a real rocket, measured it with a ruler, and built a computer simulation that matches the video. We then compared a normal stick (28.5 cm) with a half-length stick (about 14 cm).

**The big idea in one line:** the stick works like the feathers on an arrow. It keeps the rocket pointing in the direction it is travelling.

## 2. The rocket we studied

Figure 1 shows the rocket and a hand-drawn sketch with its measurements. The pointed red cap (nose cone) is 2.5 cm long. The gold paper tube that holds the fuel is 6 cm long and about 1.5 cm wide. The thin striped stick is 28.5 cm long. The little grey tube sticking out of the bottom is the fuse.

&#91;image: Photo of the rocket with a hand-drawn sketch of its measurements\]

*Figure 1. The rocket and its measurements: nose cone 2.5 cm, body 6 cm, width about 1.5 cm, stick 28.5 cm.*

Figure 2 shows two identical rockets side by side next to a ruler. The one on the right has the normal stick (28.5 cm). The one on the left has a stick cut to about half of that length (about 14 cm). Everything else about the two rockets is the same, so any difference in flight must come from the stick.

&#91;image: Two rockets next to a ruler, normal stick and half stick\]

*Figure 2. Normal stick (right) and half-length stick (left), measured against a ruler in centimetres.*

## 3. Stability theory made simple

**What does stable mean?** Imagine a marble inside a bowl. Push it a little and it rolls back to the middle. That is stable. A marble on top of an upside-down bowl rolls away when pushed. That is unstable. A rocket is stable if, when something knocks its nose off course, it swings back to straight by itself.

**Two special points.** Two points on the rocket decide whether it is stable:

- **Centre of gravity (CG):** the balance point of the rocket. If you hung the rocket from a string at this point, it would stay level. Gravity and the rocket's weight act through here, and the rocket turns around this point.
- **Centre of pressure (CP):** the point where the push of the air on the side of the rocket acts, added up over the whole rocket. Large flat areas, like a stick, pull this point toward themselves.

**The weathervane rule.** A weathervane on a roof turns to point into the wind because its large tail is behind its pivot. A rocket works the same way. If the CP is **behind** the CG (closer to the tail), then when the nose tilts, the air pushes harder on the tail and swings the rocket back into line. If the CP is **in front of** the CG, the air pushes the nose further off course and the rocket tumbles.

**Measuring stability in calibres.** We measure how far the CP is behind the CG and divide by the rocket's width, d. This gives the stability margin:

**Stability margin (calibres) = (CP - CG) / d**

A calibre is simply one body width, about 1.5 cm for our rocket. Rocket builders use a rule of thumb: a margin of **at least 1 calibre** is the minimum for stable flight, and more is safer.

**Weathervane strength.** The margin tells us if the rocket is stable, but not how strongly it corrects itself. For that we use a second number, K = (total side area) x (CP - CG). A bigger K means a stronger swing back to straight.

**What the stick does.** A longer stick adds side area far behind the nose, so it drags the CP backward. It also adds some weight at the back, which moves the CG backward too, but by much less. The gap between CP and CG therefore grows as the stick gets longer.

**Why not use a really long stick?** A longer stick is also heavier and catches more air, so the rocket climbs less high. Stick length is a trade-off between flying straight and flying high.

## 4. What the real flight looked like

Figure 3 shows nine photos (A to I) from our video of the launch, in time order. In A the rocket has just lifted off the ground and is only a small flame. By F to I it is high above the street, trailing a long line of sparks. The flight is mostly upward, with a slight lean to the left near the top. Part of that lean may come from the camera angle.

&#91;image: Nine video frames A to I of the rocket launch\]

*Figure 3. Nine video frames (A to I) of the rocket taking off from the street.*

Figure 4 shows the same launch filmed with the camera pointed up at the sky. Reading left to right and top to bottom, the glowing rocket enters from the bottom right corner and climbs higher in each frame. The street lights and buildings do not move, so the rocket's height is easy to compare from frame to frame.

&#91;image: Nine frames from the upward-looking camera showing the rocket climbing\]

*Figure 4. Nine video frames from the upward-looking camera. The rocket climbs a little higher in each frame.*

## 5. How high and how fast: the height and speed graph

Figure 5 comes from our computer simulation, adjusted until it matched the video. The top graph shows the **height** of the rocket over time. The bottom graph shows its **speed** over time. The dashed vertical line at 0.5 seconds marks **burn-out**, the moment the fuel runs out.

&#91;image: Graphs of rocket height and speed against time\]

*Figure 5. Simulated height (top) and speed (bottom) of the normal rocket. Burn-out is at 0.5 s. The green line at 2 s is when the rocket burst in the video.*

- **0 to 0.5 s (burning):** the fuel pushes the rocket with a force of about 0.36 newtons. Its speed climbs quickly to a peak of about 16 metres per second, and it rises about 3.7 m.
- **0.5 to 2 s (coasting):** with no more push, gravity and air slow the rocket down in a steady, straight-line drop in speed. It keeps rising because it is still moving up.
- **At about 2 s:** the speed reaches zero at the top of the flight, at a height of about 15.4 m. This is the apogee, the highest point. The rocket burst at about this time in the video.

## 6. Where the CG and CP sit

Figure 6 draws both rockets to scale. The red triangle is the nose cone, the yellow part is the fuel body, and the long grey bar is the stick. The red dot is the CG at launch and the blue triangle is the CP.

&#91;image: Scale drawings of the normal and half stick rockets with CG and CP marked\]

*Figure 6. Normal stick (top) and half stick (bottom). The CP is 6.6 cm behind the CG for the normal stick, but only 2.7 cm behind for the half stick.*

- **Normal stick:** the CP is 6.6 cm behind the CG. That is **4.14 calibres**, a comfortable margin.
- **Half stick:** the CP is only 2.7 cm behind the CG. That is **1.79 calibres**. This still passes the 1-calibre rule, but it is less than half the safety margin.

So the half-stick rocket is technically stable, but only just.

## 7. How stick length changes stability

Figure 7 has three graphs. All of them use stick length (below the body) on the horizontal axis.

&#91;image: Three graphs: stability margin, CP and CG positions, and weathervane strength versus stick length\]

*Figure 7. (a) Stability margin, (b) CP and CG positions, (c) weathervane strength K, all plotted against stick length.*

- **Graph (a), stability margin:** the margin grows as the stick gets longer. It reaches the 1-calibre target line at a stick of about 10 cm. Our half stick (about 14 cm) is at roughly 1.8 calibres and our normal stick (28.5 cm) is at roughly 4.1. The solid blue line is at launch and the red dashed line is at burn-out. They are close together, so using up the fuel does not change the story much.
- **Graph (b), CP and CG positions:** this shows why a longer stick helps. Both points move backward as the stick grows, but the CP (blue) moves back much faster than the CG (red). The gap between them keeps widening.
- **Graph (c), weathervane strength K:** K is small for a short stick and grows quickly for a long one. At the half stick K is about 55 cm cubed. At the normal stick it is about 190 cm cubed, roughly **3.5 times stronger**. That is why the normal rocket corrects itself so much better.

## 8. Normal stick versus half stick in flight

Figure 8 compares the two simulated flights. In both graphs, **blue is the normal stick** and **orange is the half stick**.

&#91;image: Simulated flight paths and pitch angle for the normal and half stick rockets\]

*Figure 8. (a) Flight paths seen from the side. (b) Pitch angle, or how far the nose is tilted from straight up, over time.*

- **Graph (a), flight paths:** the normal rocket goes almost straight up. The half-stick rocket leans and bends away, ending about 1.5 m to the side by the time it is 17 m high.
- **Graph (b), pitch angle:** pitch is the tilt of the nose from vertical, where 0 degrees means perfectly upright. The normal rocket stays within about 2 degrees all the way. The half-stick rocket tips quickly in the first half second, wobbles, and then keeps tipping to about 25 degrees by 2 seconds.

Both rockets are stable by the rule of thumb, yet the half-stick rocket still wanders. A small margin means a weak correction, so small disturbances grow instead of dying away.

## 9. Finding the best stick length

Figure 9 repeats the simulation for many stick lengths to find the best one.

&#91;image: Max pitch angle, sideways drift and apogee versus stick length\]

*Figure 9. (a) How straight the rocket flies, and (b) how high it goes, for different stick lengths.*

- **Graph (a), how straight:** the blue line (left axis) is the biggest tilt angle during the flight and the orange line (right axis) is how far it drifts sideways at the burst. For sticks shorter than about 8 cm the tilt is at its maximum, which means the rocket tumbles. As the stick gets longer both lines fall steeply and reach nearly zero at about 22 to 25 cm, where the rocket flies straightest. Past that point they creep up slightly, but only by a few degrees. Our half stick (about 14 cm) is still tilting about 25 degrees. Our normal stick (28.5 cm) is down to a few degrees.
- **Graph (b), how high:** shorter sticks give slightly more height because the rocket is lighter and meets less air. The apogee falls steadily from about 18.9 m for a very short stick to about 13 m for a 45 cm stick. The normal stick reaches about 15.3 m. The half stick reaches about 17.6 m, so the normal stick costs only about 2 m of height.

The best choice is a stick of **about 22 to 28 cm**. It flies almost perfectly straight and gives up only a little height.

## 10. Conclusions

- A rocket flies straight when its **CP is behind its CG**, like the tail of a weathervane.
- The **stick moves the CP backward**, so a longer stick makes the rocket more stable.
- Our normal stick (28.5 cm) has a margin of **4.14 calibres**. The half stick has **1.79 calibres**.
- Even though the half stick passes the 1-calibre rule, it has about **3.5 times weaker** self-correction, and in the simulation it tilts to about 25 degrees and drifts about 1.5 m sideways.
- Longer sticks cost height, but the loss is small: about 2 m between the half and normal stick.
- A stick length of about 22 to 28 cm is the best balance of straight flight and height for this rocket.

**Note.** The numbers for thrust, tilt and drift come from a computer simulation fitted to our video, so they are good estimates, not exact measurements. Fireworks are dangerous. This study was done to understand the physics, and should not be copied without proper safety precautions.
