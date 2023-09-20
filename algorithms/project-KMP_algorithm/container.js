// based on github.com/markdown-it/markdown-it-container

export default function containerPlugin(md, name, options) {
    function validateDefault(params) {
        return params.trim().split(' ', 2)[0] === name;
    }

    function renderDefault(tokens, idx, options, env, slf) {
        if (tokens[idx].nesting === 1) {
            tokens[idx].attrJoin('class', name);
        }
        return slf.renderToken(tokens, idx, options, env, slf);
    }

    options = options || {};

    const minMarkers = 3;
    const markerStr = options.marker || ':';
    const markerChar = markerStr.charCodeAt(0);
    const markerLen = markerStr.length;
    const validate = options.validate || validateDefault;
    const render = options.render || renderDefault;

    function container(state, startLine, endLine, silent) {
        let pos;
        let token;

        let autoClosed = false;
        let start = state.bMarks[startLine] + state.tShift[startLine];
        let max = state.eMarks[startLine];

        if (markerChar !== state.src.charCodeAt(start)) {
            return false;
        }

        for (pos = start + 1; pos <= max; pos++) {
            if (markerStr[(pos - start) % markerLen] !== state.src[pos]) {
                break;
            }
        }

        const markerCount = Math.floor((pos - start) / markerLen);
        if (markerCount < minMarkers) {
            return false;
        }
        pos -= (pos - start) % markerLen;

        const markup = state.src.slice(start, pos);
        const params = state.src.slice(pos, max);
        if (!validate(params, markup)) {
            return false;
        }

        if (silent) {
            return true;
        }

        let nextLine = startLine;

        let refIndent = null;

        for (; ;) {
            nextLine++;
            if (nextLine >= endLine) {
                break;
            }

            start = state.bMarks[nextLine] + state.tShift[nextLine];
            max = state.eMarks[nextLine];

            if (start < max) {
                const indent = state.sCount[nextLine] - state.blkIndent;
                if (refIndent === null) {
                    refIndent = indent;
                } else {
                    if (indent < refIndent) {
                        break;
                    }
                }
            }

            if (start < max && state.sCount[nextLine] < state.blkIndent) {
                break;
            }

            if (markerChar !== state.src.charCodeAt(start)) {
                continue;
            }

            for (pos = start + 1; pos <= max; pos++) {
                if (markerStr[(pos - start) % markerLen] !== state.src[pos]) {
                    break;
                }
            }

            if (Math.floor((pos - start) / markerLen) < markerCount) {
                continue;
            }

            pos -= (pos - start) % markerLen;
            pos = state.skipSpaces(pos);

            if (pos < max) {
                continue;
            }

            autoClosed = true;
            break;
        }

        const oldParent = state.parentType;
        const oldLineMax = state.lineMax;
        state.parentType = 'container';
        state.blkIndent += refIndent;

        state.lineMax = nextLine;

        token = state.push(`container_${name}_open`, 'div', 1);
        token.markup = markup;
        token.block = true;
        token.info = params;
        token.map = [startLine, nextLine];

        state.md.block.tokenize(state, startLine + 1, nextLine);

        token = state.push(`container_${name}_close`, 'div', -1);
        token.markup = state.src.slice(start, pos);
        token.block = true;

        state.blkIndent -= refIndent;
        state.parentType = oldParent;
        state.lineMax = oldLineMax;
        state.line = nextLine + (autoClosed ? 1 : 0);

        return true;
    }

    md.block.ruler.before('fence', `container_${name}`, container, {
        alt: ['paragraph', 'reference', 'blockquote', 'list'],
    });
    md.renderer.rules[`container_${name}_open`] = render;
    md.renderer.rules[`container_${name}_close`] = render;
}
