import fs from 'fs';
import through from 'through2';
import PluginError from 'plugin-error';
import path from 'path';
import Handlebars from 'handlebars';
import MarkdownIt from 'markdown-it';
import MarkdownItMathJax from 'markdown-it-mathjax';
import MarkdownItInclude from 'markdown-it-include';
import MarkdownItTable from 'markdown-it-multimd-table';
import container from './container.js';
import kbd from 'markdown-it-kbd';
import { colorPlugin } from 'markdown-it-color';
import { JSDOM } from 'jsdom';


const PLUGIN_NAME = 'orfalius';


const warningOptions = {
    validate: function () {
        return true;
    },
    render: function (tokens, idx) {
        const tail = tokens[idx].info.trim();
        const title = tail ? tail.split(/\s+/).join(' ') : 'Aviso';
        if (tokens[idx].nesting === 1) {
            return `<blockquote class="warning">\n<p>${title}</p>\n`;
        } else {
            return '</blockquote>\n';
        }
    },
    marker: '!',
};

const questionOptions = {
    validate: function () {
        return true;
    },
    render: function (tokens, idx) {
        const tail = tokens[idx].info.trim();
        const title = tail ? tail.split(/\s+/).join(' ') : 'Pergunta';
        if (tokens[idx].nesting === 1) {
            return `<blockquote class="question">\n<p>${title}</p>\n`;
        } else {
            return '</blockquote>\n';
        }
    },
    marker: '?',
};

const answerOptions = {
    validate: function () {
        return true;
    },
    render: function (tokens, idx) {
        const tail = tokens[idx].info.trim();
        const title = tail ? tail.split(/\s+/).join(' ') : 'Resposta';
        if (tokens[idx].nesting === 1) {
            return `<details class="answer">\n<summary>${title}</summary>\n`;
        } else {
            return '</details>\n';
        }
    },
    marker: ':',
};

const fileOptions = {
    validate: function (params) {
        return params.trim();
    },
    render: function (tokens, idx) {
        const tail = tokens[idx].info.trim();
        const title = tail.split(/\s+/).join(' ');
        if (tokens[idx].nesting === 1) {
            return `<details class="file">\n<summary>${title}</summary>\n`;
        } else {
            return '</details>\n';
        }
    },
    marker: '´',
};

const checkOptions = {
    validate: function () {
        return true;
    },
    render: function (tokens, idx) {
        const tail = tokens[idx].info.trim();
        const title = tail ? tail.split(/\s+/).join(' ') : 'clique aqui para continuar';
        if (tokens[idx].nesting === 1) {
            return `<details class="check">\n<summary>${title}</summary>\n`;
        } else {
            return '</details>\n';
        }
    },
    marker: ',',
};

const sectionOptions = {
    validate: function (params) {
        return params.trim();
    },
    render: function (tokens, idx) {
        const tail = tokens[idx].info.trim();
        const title = tail.split(/\s+/).join(' ');
        if (tokens[idx].nesting === 1) {
            return `<details class="section">\n<summary>${title}</summary>\n`;
        } else {
            return '</details>\n';
        }
    },
    marker: ';',
};

const itemOptions = {
    validate: function (params) {
        return params.trim();
    },
    render: function (tokens, idx) {
        const tail = tokens[idx].info.trim();
        const title = tail.split(/\s+/).join(' ');
        if (tokens[idx].nesting === 1) {
            return `<div class="item">\n<div class="item-marker">\n${title}\n</div>\n<div class="item-content">\n`;
        } else {
            return '</div>\n</div>\n';
        }
    },
    marker: '|',
};

const timesOptions = {
    validate: function (params) {
        return params.trim();
    },
    render: function (tokens, idx) {
        const tail = tokens[idx].info.trim();
        const title = tail.split(/\s+/).join(' ');
        if (tokens[idx].nesting === 1) {
            return `<video class="reader-lecture" src="vid/${title}"></video>\n<pre class="times">\n`;
        } else {
            return '</pre>\n';
        }
    },
    marker: '//////',
};

const slideOptions = {
    validate: function () {
        return true;
    },
    render: function (tokens, idx) {
        const tail = tokens[idx].info.trim();
        const title = tail.split(/\s+/).join(' ');
        if (tokens[idx].nesting === 1) {
            return `<div class="slide">\n<div class="slide-container">\n<div class="slide-header">\n${title}\n</div>\n<div class="slide-main">\n`;
        } else {
            return '</div>\n</div>\n</div>\n';
        }
    },
    marker: '++++++++++++++',
};

const handoutOptions = {
    validate: function () {
        return true;
    },
    render: function (tokens, idx) {
        if (tokens[idx].nesting === 1) {
            return '<div class="handout">\n';
        } else {
            return '</div>\n';
        }
    },
    marker: '^',
};


function replace(reference, element) {
    const parent = reference.parentElement;
    parent.insertBefore(element, reference);
    reference.remove();
}

function wrapFigure(document, element, className) {
    const figure = document.createElement('figure');
    figure.setAttribute('class', className);
    figure.append(element);
    return figure;
}

function processImage(element, prefix) {
    let src = element.src;
    const re = /(?<!%7C)(\%7C\%7C)*(\%7C)(?!%7C)/g;
    const match = re.exec(src);
    if (match && !re.exec(src)) {
        element.setAttribute('style', `max-height: ${src.slice(match.index + 3)}em;`);
        src = src.slice(0, match.index);
    }
    if (!src.startsWith('..')) {
        src = `img/${src}`;
        if (prefix === '/') {
            src = `/${src}`;
        }
    }
    element.setAttribute('src', src);
}

function processChildren(document, element, dirname, prefix) {
    const removable = [];
    for (const child of element.children) {
        let innerHTML;
        switch (child.tagName) {
            case 'P':
                removable.push(...processParagraph(document, child, dirname, prefix));
                break;
            case 'TABLE':
                const figure = document.createElement('figure');
                replace(child, figure);
                figure.setAttribute('class', 'table');
                figure.append(child);
                const th = child.firstElementChild.firstElementChild.firstElementChild;
                innerHTML = th.innerHTML;
                if (innerHTML === 'x') {
                    child.setAttribute('class', 'cross');
                    th.innerHTML = '';
                } else if (innerHTML === '^x') {
                    th.innerHTML = innerHTML.slice(1);
                }
            case 'TR':
            case 'UL':
            case 'OL':
                for (const grandChild of child.children) {
                    removable.push(...processParagraph(document, grandChild, dirname, prefix));
                }
                break;
            case 'BLOCKQUOTE':
            case 'DETAILS':
            case 'DIV':
            case 'EM':
            case 'STRONG':
            case 'SPAN':
                removable.push(...processChildren(document, child, dirname, prefix));
                break;
            case 'PRE':
                if (child.classList.contains('times')) {
                    const grandChild = child.firstElementChild;
                    grandChild.remove();
                    child.innerHTML = `\n${grandChild.innerHTML}\n`;
                } else {
                    const code = child.querySelector('code');
                    if (!code.hasAttribute('class')) {
                        code.setAttribute('class', 'terminal nohighlight');
                    }
                }
                break;
            case 'CODE':
                let className = 'terminal nohighlight';
                innerHTML = child.innerHTML;
                if (innerHTML.startsWith('~')) {
                    child.innerHTML = innerHTML = innerHTML.slice(1);
                } else {
                    const index = innerHTML.search(/\s/);
                    if (index > 0) {
                        className = `language-${innerHTML.slice(0, index)}`;
                        child.innerHTML = innerHTML.slice(index + 1);
                    }
                }
                child.setAttribute('class', className);
                break;
            case 'A':
                if (child.href.startsWith('http')) {
                    child.setAttribute('target', '_blank');
                }
                break;
            case 'IMG':
                processImage(child, prefix);
                break;
            default:
        }
    }
    return removable;
}


function processParagraph(document, element, dirname, prefix) {
    const removable = [];

    const innerHTML = element.innerHTML;

    if (innerHTML.startsWith('@') && !innerHTML.startsWith('@@')) {
        // ANCHOR
        const id = innerHTML.slice(1);
        const a = document.createElement('a');
        a.setAttribute('class', 'anchor');
        a.setAttribute('id', id);
        replace(element, a);

    } else if (innerHTML.startsWith('!') && !innerHTML.startsWith('!!')) {
        // ALERT
        element.setAttribute('class', 'alert');
        element.innerHTML = innerHTML.slice(1);
        removable.push(...processChildren(document, element, dirname, prefix));

    } else if (innerHTML.startsWith('+') && !innerHTML.startsWith('++')) {
        // FRAME
        const parent = element.parentElement;
        if (parent.tagName === 'LI' && element.previousElementSibling === null && element.nextElementSibling === null) {
            parent.classList.add('frame');
        } else {
            element.classList.add('frame');
        }
        element.innerHTML = innerHTML.slice(1);
        removable.push(...processParagraph(document, element, dirname, prefix));

    } else if (innerHTML.startsWith('^') && !innerHTML.startsWith('^^')) {
        // SMALL
        const parent = element.parentElement;
        if (parent.tagName === 'LI' && element.previousElementSibling === null && element.nextElementSibling === null) {
            parent.classList.add('small');
        } else {
            element.classList.add('small');
        }
        element.innerHTML = innerHTML.slice(1);
        removable.push(...processParagraph(document, element, dirname, prefix));

    } else if (innerHTML.startsWith(':') && !innerHTML.startsWith('::')) {
        // ANIMATION
        const tail = innerHTML.slice(1).trim();
        if (tail) {
            const folder = `img/${tail}`;
            const fileNames = fs.readdirSync(`${dirname}/${folder}`);
            fileNames.sort();
            const imgs = [];
            for (const [i, fileName] of fileNames.entries()) {
                const img = document.createElement('img');
                img.setAttribute('class', 'frame');
                img.setAttribute('src', `${tail}/${encodeURI(fileName.replace(/\|/g, '||'))}`);
                img.setAttribute('alt', i + 1);
                imgs.push(img);
            }
            if (imgs.length > 0) {
                const animation = document.createElement('div');
                animation.setAttribute('class', 'animation');
                for (const img of imgs) {
                    animation.append(img);
                    processImage(img, prefix);
                }
                replace(element, animation);
            }
        }

    } else if (innerHTML.startsWith(';') && !innerHTML.startsWith(';;')) {
        // VIDEO
        const words = innerHTML.trim().slice(1).split(';');
        const video = document.createElement('video');
        let src = words[0];
        if (!src.startsWith('http')) {
            src = `vid/${src}`;
        }
        video.setAttribute('src', src);
        if (words.length > 1) {
            video.setAttribute('poster', `vid/${words[1]}`);
        }
        video.setAttribute('controls', '');
        const figure = wrapFigure(document, video, 'video');
        replace(element, figure);

    } else if (innerHTML.startsWith('&amp;') && !innerHTML.startsWith('&amp;&amp;')) {
        // CODEPEN
        const words = innerHTML.trim().slice(5).split('&amp;');
        element.setAttribute('class', 'codepen');
        element.setAttribute('data-theme-id', 'dark');
        element.setAttribute('data-user', words[0]);
        element.setAttribute('data-slug-hash', words[1]);
        element.setAttribute('data-default-tab', words[2]);
        element.innerHTML = '';

    } else {
        const child = element.firstElementChild;

        if (element.tagName !== 'TD' && element.children.length === 1 && child.tagName === 'IMG') {
            // IMAGE
            child.remove();
            const figure = wrapFigure(document, child, 'img');
            replace(element, figure);
            processImage(child, prefix);

        } else {
            // P
            if (innerHTML.startsWith('~')) {
                element.innerHTML = innerHTML.slice(1);
            }
            removable.push(...processChildren(document, element, dirname, prefix));
        }
    }

    return removable;
}


export default function (templatePath) {
    return through.obj(function (file, encoding, callback) {
        if (file.isStream()) {
            this.emit('error', new PluginError(PLUGIN_NAME, 'Streams not supported!'));
        }

        if (file.isBuffer()) {
            const dirname = path.dirname(file.path);

            const templateContents = fs.readFileSync(templatePath);
            const template = Handlebars.compile(templateContents.toString());

            const includeOptions = {
                root: dirname,
                includeRe: /\{\{(.+?)\}\}/,
                bracesAreOptional: true,
            };

            const tableOptions = {
                multiline: true,
                rowspan: true,
                headerless: true,
            };

            const md = MarkdownIt({ html: true, typographer: true })
                .disable(['code', 'blockquote'])
                .use(MarkdownItMathJax())
                .use(MarkdownItInclude, includeOptions)
                .use(MarkdownItTable, tableOptions)
                .use(container, 'warning', warningOptions)
                .use(container, 'question', questionOptions)
                .use(container, 'answer', answerOptions)
                .use(container, 'file', fileOptions)
                .use(container, 'check', checkOptions)
                .use(container, 'section', sectionOptions)
                .use(container, 'item', itemOptions)
                .use(container, 'times', timesOptions)
                .use(container, 'slide', slideOptions)
                .use(container, 'handout', handoutOptions)
                .use(kbd)
                .use(colorPlugin);

            const htmlString = md.render(file.contents.toString());
            const document = (new JSDOM(htmlString)).window.document;
            const body = document.querySelector('body');

            const h1s = body.querySelectorAll('h1');

            if (h1s.length !== 1) {
                throw new SyntaxError(`${file.path}: must have exactly one H1`);
            }

            let first = body.firstElementChild;

            while (first.tagName === 'P' && first.innerHTML.startsWith('!')) {
                first = first.nextElementSibling;
            }

            if (first.tagName !== 'H1') {
                let second = first.nextElementSibling;

                while (second.tagName === 'P' && second.innerHTML.startsWith('!')) {
                    second = second.nextElementSibling;
                }

                if (first.tagName !== 'P' || second.tagName !== 'H1') {
                    throw new SyntaxError(`${file.path}: must start with H1 or P followed by H1`);
                }
            }

            let copyright;
            let title = h1s[0].innerHTML;
            const index = title.indexOf('[C]');
            if (index !== -1) {
                copyright = title.slice(index + 3);
                title = title.slice(0, index);
            } else {
                copyright = 'Marcelo Hashimoto';
            }
            h1s[0].innerHTML = title.trim();

            let prefix;
            if (path.basename(dirname) === 'error') {
                prefix = '/';
            } else {
                const paths = path.relative('.', file.path).split(path.sep);
                prefix = '../'.repeat(paths.length - 2);
            }

            for (const element of processChildren(document, body, dirname, prefix)) {
                element.remove();
            }

            const contents = body.innerHTML;

            const fileString = template({
                title: title,
                prefix: prefix,
                contents: contents,
                copyright: copyright,
            });

            file.contents = Buffer.from(fileString);
            file.path = `${file.path.slice(0, -2)}html`;
        }

        callback(null, file);
    });
}
