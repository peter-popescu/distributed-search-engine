// @ts-check
/**
 * @typedef {import("../types.js").Callback} Callback
 * @typedef {import("../types.js").Config} Config
 * @typedef {import("../types.js").Node} Node
 */

/**
 * @param {string} name
 * @param {(e: Error | null, v: Object.<string, Node> | null) => void} callback
 */
function get(name, callback) {
}

/**
 * @param {Config | string} config
 * @param {Object.<string, Node>} group
 * @param {(e: Error | null, v: Object.<string, Node> | null) => void} callback
 */
function put(config, group, callback) {
}

/**
 * @param {string} name
 * @param {Callback} callback
 */
function del(name, callback) {
}

/**
 * @param {string} name
 * @param {Node} node
 * @param {Callback} callback
 */
function add(name, node, callback) {
};

/**
 * @param {string} name
 * @param {string} node
 * @param {Callback} callback
 */
function rem(name, node, callback) {
};

module.exports = {get, put, del, add, rem};
