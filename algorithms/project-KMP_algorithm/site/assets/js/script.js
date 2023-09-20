const DELTA = 0.000001;

const SLIDE_WIDTH = 704;
const SLIDE_HEIGHT = 396;


function hide(element) {
    element.style.display = 'none';
}

function show(element, display) {
    element.style.display = display;
}

function disable(button) {
    button.classList.add('disabled');
}

function enable(button) {
    button.classList.remove('disabled');
}

function createButton(controls, symbol) {
    const button = document.createElement('a');
    button.setAttribute('class', 'button');
    button.setAttribute('href', '');
    button.innerHTML = symbol;
    controls.append(button);
    return button;
}

function createJSON(times, timeline) {
    let data = {
        'times': times,
        'timeline': timeline,
    };
    data = encodeURI(JSON.stringify(data, null, 4));
    const a = document.createElement('a');
    a.setAttribute('href', `data:application/json,${data}`);
    a.setAttribute('download', 'edit.json');
    a.click();
}

function updateTime(lecture, time) {
    lecture.setAttribute('automatic', '');
    lecture.currentTime = time;
}

function updateTimeFromSlides(slides, index, lecture) {
    let i = index - 1;
    let time;
    while (i > -1) {
        time = slides[i].time;
        if (!isNaN(time)) {
            break;
        }
        i--;
    }
    if (i === -1) {
        updateTime(lecture, 0);
    } else {
        updateTime(lecture, time);
    }
}

function updateScale(slides, index, stamp, lecture) {
    slides[index].updateScale(stamp, lecture);
}

function updateReader(slides, index, stamp, lecture, playButton, prevButton, nextButton, counter) {
    show(slides[index].element, 'block');
    updateScale(slides, index, stamp, lecture);
    if (isNaN(slides[index].time)) {
        if (lecture) {
            show(stamp, 'block');
            lecture.pause();
        }
        disable(playButton);
    } else {
        if (lecture) {
            hide(stamp);
        }
        enable(playButton);
    }
    if (index === 0) {
        disable(prevButton);
    } else {
        enable(prevButton);
    }
    if (index === slides.length - 1) {
        disable(nextButton);
    } else {
        enable(nextButton);
    }
    counter.innerHTML = `${index + 1}/${slides.length}`;
}

function updateAnimation(imgs, index, leftButton, rightButton, counter) {
    show(imgs[index], 'inline');
    if (index === 0) {
        disable(leftButton);
    } else {
        enable(leftButton);
    }
    if (index === imgs.length - 1) {
        disable(rightButton);
    } else {
        enable(rightButton);
    }
    counter.innerHTML = `${index + 1}/${imgs.length}`;
}


class Slide {
    constructor(element) {
        this.element = element;
        this.time = NaN;
        this.container = element.querySelector('div.slide-container');
        this.width = null;
    }

    transform(element, scale) {
        element.style.transform = `scale(${scale})`;
    }

    updateScale(stamp, lecture) {
        const rect = this.element.getBoundingClientRect();
        if (this.width !== rect.width) {
            this.width = rect.width;
            const scale = Math.min(rect.width / SLIDE_WIDTH, rect.height / SLIDE_HEIGHT);
            if (scale > DELTA) {
                this.transform(this.container, scale);
                if (lecture) {
                    this.transform(stamp, scale);
                    this.transform(lecture, scale);
                }
            }
        }
    }
}


document.addEventListener('DOMContentLoaded', function () {
    const page = (new URLSearchParams(window.location.search)).get('slide');

    for (const code of document.querySelectorAll('code')) {
        hljs.highlightElement(code);
    }

    for (const code of document.querySelectorAll('pre > code')) {
        const lines = code.innerHTML.split('\n');
        for (let i = 0; i < lines.length; i++) {
            if (lines[i].endsWith('***</span>')) {
                lines[i] = `<mark>${lines[i].slice(0, -10).trimEnd()}</span></mark>`;
            } else if (lines[i].endsWith('***')) {
                lines[i] = `<mark>${lines[i].slice(0, -3).trimEnd()}</mark>`;
            } else if (lines[i].endsWith('!!!</span>')) {
                lines[i] = `<mark class="error">${lines[i].slice(0, -10).trimEnd()}</span></mark>`;
            } else if (lines[i].endsWith('!!!')) {
                lines[i] = `<mark class="error">${lines[i].slice(0, -3).trimEnd()}</mark>`;
            } else if (lines[i].endsWith('~</span>')) {
                lines[i] = `${lines[i].slice(0, -8)}</span>\n`;
            } else if (lines[i].endsWith('~')) {
                lines[i] = `${lines[i].slice(0, -1)}\n`;
            } else if (i < lines.length - 1) {
                lines[i] = `${lines[i]}\n`;
            }
        }
        code.innerHTML = lines.join('');
    }

    const slides = [];
    let index = 0;
    let stamp;
    const lecture = document.querySelector('video.reader-lecture');

    const main = document.querySelector('main');

    let slideTitle = '';

    for (const element of document.querySelectorAll('div.slide')) {
        const header = element.querySelector('div.slide-header');
        if (header.innerHTML.trim() === '=') {
            header.innerHTML = slideTitle;
        } else {
            slideTitle = header.innerHTML;
        }
        const displays = [];
        const frames = element.querySelectorAll('.frame');
        for (const frame of frames) {
            displays.push(frame.style.display);
            frame.style.display = 'none';
        }
        for (let i = 0; i < frames.length; i++) {
            const clone = document.createElement('div');
            clone.setAttribute('class', 'slide');
            clone.innerHTML = element.innerHTML;
            main.insertBefore(clone, element);
            slides.push(new Slide(clone));
            frames[i].style.display = displays[i];
            if (i > 0) {
                frames[i - 1].classList.remove('md-colorify--red');
            }
            frames[i].classList.add('md-colorify--red');
        }
        slides.push(new Slide(element));
    }

    if (slides.length > 0) {
        const value = parseInt(page);

        if (!isNaN(value) && value > 0 && value <= slides.length) {
            index = value - 1;
        }

        const h1 = document.querySelector('h1');
        const parent = h1.parentElement;
        const reference = h1.nextElementSibling;

        const details = document.createElement('details');
        details.setAttribute('class', 'reader');

        const hr = document.createElement('hr');

        parent.insertBefore(details, reference);
        parent.insertBefore(hr, reference);

        const summary = document.createElement('summary');
        if (lecture) {
            summary.innerHTML = 'VideoSlides';
        } else {
            summary.innerHTML = 'Slides';
        }
        details.append(summary);

        const controls = document.createElement('div');
        controls.setAttribute('class', 'reader-controls');
        details.append(controls);

        const recIndicator = document.createElement('span');
        recIndicator.setAttribute('class', 'indicator');
        recIndicator.innerHTML = '⏺';
        controls.append(recIndicator);

        const prevButton = createButton(controls, '⏮');
        const playButton = createButton(controls, '▶');
        const pauseButton = createButton(controls, '⏸');
        const nextButton = createButton(controls, '⏭');
        const fullButton = createButton(controls, '⛶');

        const counter = document.createElement('span');
        counter.setAttribute('class', 'reader-counter');
        controls.append(counter);

        const display = document.createElement('div');
        display.setAttribute('class', 'reader-display');
        details.append(display);

        for (const slide of slides) {
            slide.element.remove();
            display.append(slide.element);
        }

        let times = document.querySelector('pre.times');
        if (times) {
            times = times.innerHTML.trim().split(/\s+/);
            for (let i = 0; i < slides.length && i < times.length; i++) {
                slides[i].time = parseFloat(times[i]);
            }
        }

        if (lecture) {
            stamp = document.createElement('div');
            stamp.setAttribute('class', 'stamp');
            display.append(stamp);

            display.append(lecture);

            updateTimeFromSlides(slides, index, lecture);

            lecture.addEventListener('play', function () {
                hide(playButton);
                show(pauseButton, 'inline');
                show(lecture, 'block');
            });

            lecture.addEventListener('pause', function () {
                hide(lecture);
                hide(pauseButton);
                show(playButton, 'inline');
            });

            lecture.addEventListener('timeupdate', function () {
                if (!lecture.seeking) {
                    let time = slides[index].time;
                    if (isNaN(time)) {
                        lecture.pause();
                        let i = index - 1;
                        while (i > -1) {
                            time = slides[i].time;
                            if (!isNaN(time)) {
                                break;
                            }
                            i--;
                        }
                        if (i === -1) {
                            updateTime(lecture, 0);
                        } else {
                            updateTime(lecture, time);
                        }
                    } else {
                        if (lecture.currentTime > time - DELTA) {
                            hide(slides[index].element);
                            if (index === slides.length - 1) {
                                lecture.pause();
                                updateTime(lecture, 0);
                                index = 0;
                            } else {
                                index++;
                            }
                            updateReader(slides, index, stamp, lecture, playButton, prevButton, nextButton, counter);
                        }
                    }
                }
            });

            lecture.addEventListener('seeked', function () {
                if (lecture.hasAttribute('automatic')) {
                    lecture.removeAttribute('automatic');
                } else {
                    if (!lecture.seeking) {
                        let i = 0;
                        let last = 0;
                        while (i < slides.length) {
                            const time = slides[i].time;
                            if (!isNaN(time)) {
                                last = time;
                                if (time > lecture.currentTime + DELTA) {
                                    break;
                                }
                            }
                            i++;
                        }
                        if (i === slides.length) {
                            if (!lecture.paused) {
                                lecture.pause();
                            }
                            updateTime(lecture, last);
                        } else {
                            hide(slides[index].element);
                            index = i;
                            updateReader(slides, index, stamp, lecture, playButton, prevButton, nextButton, counter);
                        }
                    }
                }
            });

            document.addEventListener('keydown', function (event) {
                switch (event.key) {
                    case 'ArrowLeft':
                        prevButton.click();
                        break;
                    case 'ArrowRight':
                        nextButton.click();
                        break;
                    default:
                }
            });
        } else {
            hide(playButton);

            let shift = 0;
            const times = [];
            let start = null;

            let subtimes;
            const timeline = [];

            document.addEventListener('keydown', function (event) {
                switch (event.key) {
                    case 'ArrowLeft':
                        if (start) {
                            const now = Date.now();
                            subtimes.push((start - now) / 1000);
                            start = now;
                        } else {
                            if (times.length > 0) {
                                let time = times.pop();
                                if (!isNaN(time)) {
                                    let i;
                                    i = times.length - 2;
                                    while (i > -1) {
                                        time = times[i];
                                        if (!isNaN(time)) {
                                            break;
                                        }
                                        i--;
                                    }
                                    if (i === -1) {
                                        shift = 0;
                                    } else {
                                        shift = time;
                                    }
                                    i = timeline.length - 1;
                                    while (timeline[i].length === 0) {
                                        i--;
                                    }
                                    timeline[i].pop();
                                }
                                if (times.length < slides.length) {
                                    counter.style.color = '#000000';
                                }
                            }
                            prevButton.click();
                        }
                        break;
                    case 'ArrowRight':
                        if (times.length < slides.length) {
                            if (start) {
                                const now = Date.now();
                                shift += (now - start) / 1000;
                                times.push(shift);
                                start = now;
                                subtimes.push(shift);
                            } else {
                                times.push(NaN);
                            }
                            if (timeline.length > 0 && times.length === slides.length) {
                                counter.style.color = '#ff0000';
                            }
                        }
                        if (timeline.length > 0 && times.length === slides.length) {
                            if (confirm('Create JSON?')) {
                                if (start) {
                                    hide(recIndicator);
                                    timeline.push(subtimes);
                                    start = null;
                                }
                                createJSON(times, timeline);
                            }
                        }
                        nextButton.click();
                        break;
                    case 'R':
                        if (start) {
                            let create = false;
                            if (times.length >= slides.length - 1) {
                                const now = Date.now();
                                create = confirm('Create JSON?');
                                if (create && times.length < slides.length) {
                                    shift += (now - start) / 1000;
                                    times.push(shift);
                                    start = now;
                                    subtimes.push(shift);
                                    counter.style.color = '#ff0000';
                                }
                            }
                            hide(recIndicator);
                            timeline.push(subtimes);
                            start = null;
                            if (create) {
                                createJSON(times, timeline);
                            }
                        } else {
                            start = Date.now();
                            subtimes = [];
                            show(recIndicator, 'inline');
                        }
                        break;
                    default:
                }
            });
        }

        hide(pauseButton);
        updateReader(slides, index, stamp, lecture, playButton, prevButton, nextButton, counter);

        window.addEventListener('resize', function () {
            updateScale(slides, index, stamp, lecture);
        });

        details.addEventListener('toggle', function () {
            updateScale(slides, index, stamp, lecture);
        });

        playButton.addEventListener('click', function (event) {
            event.preventDefault();
            if (lecture) {
                lecture.play();
            }
        });

        pauseButton.addEventListener('click', function (event) {
            event.preventDefault();
            if (lecture) {
                lecture.pause();
            }
        });

        prevButton.addEventListener('click', function (event) {
            event.preventDefault();
            if (index > 0) {
                hide(slides[index].element);
                index--;
                if (lecture) {
                    updateTimeFromSlides(slides, index, lecture);
                }
                updateReader(slides, index, stamp, lecture, playButton, prevButton, nextButton, counter);
            }
        });

        nextButton.addEventListener('click', function (event) {
            event.preventDefault();
            if (index < slides.length - 1) {
                hide(slides[index].element);
                if (lecture) {
                    const time = slides[index].time;
                    if (!isNaN(time)) {
                        updateTime(lecture, time);
                    }
                }
                index++;
                updateReader(slides, index, stamp, lecture, playButton, prevButton, nextButton, counter);
            }
        });

        fullButton.addEventListener('click', function (event) {
            event.preventDefault();
            if (display.requestFullscreen) {
                display.requestFullscreen();
            } else if (display.webkitRequestFullScreen) {
                display.webkitRequestFullScreen();
            } else if (display.mozRequestFullScreen) {
                display.mozRequestFullScreen();
            } else if (display.msRequestFullscreen) {
                display.msRequestFullscreen();
            }
        });

        document.addEventListener('mousedown', function (event) {
            if (document.fullscreenElement || document.webkitFullscreenElement || document.mozFullscreenElement || document.msFullscreenElement) {
                event.preventDefault();
                switch (event.button) {
                    case 0:
                        nextButton.click();
                        break;
                    case 2:
                        prevButton.click();
                        break;
                    default:
                }
            }
        });

        document.addEventListener('touchstart', function (event) {
            if (document.fullscreenElement || document.webkitFullscreenElement || document.mozFullscreenElement || document.msFullscreenElement) {
                event.preventDefault();
                let x = 0;
                for (const touch of event.touches) {
                    x += touch.clientX;
                }
                if (x / event.touches.length < window.screen.width / 2) {
                    prevButton.click();
                } else {
                    nextButton.click();
                }
            }
        });

        document.addEventListener('contextmenu', function (event) {
            if (document.fullscreenElement || document.webkitFullscreenElement || document.mozFullscreenElement || document.msFullscreenElement) {
                event.preventDefault();
            }
        });

        document.addEventListener('touchend', function (event) {
            if (document.fullscreenElement || document.webkitFullscreenElement || document.mozFullscreenElement || document.msFullscreenElement) {
                event.preventDefault();
            }
        });
    }

    const alerts = document.querySelectorAll('p.alert');

    if (alerts.length > 0) {
        const container = document.querySelector('div.container');

        for (const alert of alerts) {
            alert.remove();
            container.insertBefore(alert, main);
        }
    }

    for (const animation of document.querySelectorAll('div.animation')) {
        const imgs = animation.querySelectorAll('img.frame');
        let index = 0;

        const controls = document.createElement('div');
        controls.setAttribute('class', 'animation-controls');
        animation.append(controls);

        const leftButton = createButton(controls, '🡄');
        const counter = document.createElement('span');
        counter.setAttribute('class', 'animation-counter');
        controls.append(counter);
        const rightButton = createButton(controls, '🡆');

        updateAnimation(imgs, index, leftButton, rightButton, counter);

        leftButton.addEventListener('click', function (event) {
            event.preventDefault();
            if (index > 0) {
                hide(imgs[index]);
                index--;
                updateAnimation(imgs, index, leftButton, rightButton, counter);
            }
        });

        rightButton.addEventListener('click', function (event) {
            event.preventDefault();
            if (index < imgs.length - 1) {
                hide(imgs[index]);
                index++;
                updateAnimation(imgs, index, leftButton, rightButton, counter);
            }
        });
    }

    const allDetails = document.querySelectorAll('details');

    const as = document.querySelectorAll('header > a');

    if (allDetails.length > 0) {
        for (const details of allDetails) {
            details.firstElementChild.addEventListener('mousedown', function (event) {
                event.preventDefault();
            });
        }

        as[0].addEventListener('click', function (event) {
            event.preventDefault();
            for (const details of allDetails) {
                details.setAttribute('open', '');
            }
        });
        as[1].addEventListener('click', function (event) {
            event.preventDefault();
            for (const details of allDetails) {
                details.removeAttribute('open');
            }
        });
    } else {
        hide(as[0]);
        hide(as[1]);
    }

    if (page || window.location.hash) {
        as[0].click();
    }
});
