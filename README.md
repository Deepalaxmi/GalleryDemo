# Gallery with Infinite Scroll

## Language, Editor and Platform versions used in this project:
* **Language:** Swift 4.2
* **Platform:** iOS 12
* **Editor**: Xcode 10.1

## Sample Project Details
**Build a simple app with following user flows:**

1. Screen 1 - User inputs full name and clicks on start
* If text is empty, show simple alert.
* Else show full name label and current time, followed by infinite scroll grid of images
(loaded over the internet).
* Images can be obtained from imgur APIs [https//apidocs.imgur.com] or any other convenient source of large images.

2. Screen 2 - Gallery Screen

* Infinite scroll grid of images.


**Following points to be considered:**
1. Current time must update at less than 1s frequency so we can see milliseconds
2. Scroll bar should not be visible
3. Scrolling should be smooth
4. Limit memory usage, infinite scrolling should not crash the app
5. Images should load fast
6. Should work across different aspect ratios and the notch.

The focus is on the layout, making sure it adjusts across devices of various sizes and performance of the app. Write clean maintainable code following standard conventions.

**Deliverables**
* Modular and working code
* Build and run instructions
* Further enhancements/proposals
* Optional but preferred: Testflight or some other mechanism of delivering the application.

### API Details
* Used **Unsplash List Photos API** to get a single page from the list of all photos. [Reference](https://unsplash.com/documentation#list-photos)
* Demo apps are limited to 50 requests per hour while in development mode.
* Apps in production have access to 5,000 requests per hour as long as your application follows [Unsplash’s API Guidelines](https://medium.com/unsplash/unsplash-api-guidelines-28e0216e6daa) and [Terms](https://unsplash.com/api-terms).
* [Unsplash API Documentation](https://unsplash.com/documentation)

### Addiational Info
* App is showing images sorted by popularity
* Number of items per page. (Optional; default: 10)

### Screencast
[![Screencast video Gallery Demo](https://img.youtube.com/vi/gJTHWB1iXPs/0.jpg)](https://youtu.be/gJTHWB1iXPs)

### Screenshot Images

<img src="https://user-images.githubusercontent.com/12752821/49342810-b0143e00-f685-11e8-8f39-9690e62e7557.png" alt="simulator screen shot - iphone xr - 2018-12-02 at 22 53 33" width="400">

<img src="https://user-images.githubusercontent.com/12752821/49342824-f073bc00-f685-11e8-8490-9e9357681186.png" alt="simulator screen shot - iphone xr - 2018-12-02 at 22 54 265" width="400">

<img src="https://user-images.githubusercontent.com/12752821/49342839-1dc06a00-f686-11e8-96d6-adb9d767fc1d.png" alt="simulator screen shot - iphone 5s - 2018-12-02 at 22 55 03" width="300">

<img src="https://user-images.githubusercontent.com/12752821/49342840-231db480-f686-11e8-975f-4bfda946bb37.png" alt="simulator screen shot - iphone 5s - 2018-12-02 at 22 55 27" width="300">

<img src="https://user-images.githubusercontent.com/12752821/49342858-53655300-f686-11e8-8b50-05cca1c56347.png" alt="simulator screen shot - ipad air - 2018-12-02 at 22 56 31" width="400">

<img src="https://user-images.githubusercontent.com/12752821/49342860-56f8da00-f686-11e8-910a-bca818ce0b5b.png" alt="simulator screen shot - ipad air - 2018-12-02 at 22 56 38" width="400">
