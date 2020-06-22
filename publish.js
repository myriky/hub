const BORICHA_CLASSES_REGEX = /^(\d+)\s*([\w\s]+)*$/;

const fs = require("fs");
const publish = (args) => {
  if (args.length < 3) {
    console.error("usage : ./node publish.js <label_file> <dest_file>");
    process.exit(1);
  }

  var label_file = args[2];
  var dest_file = args[3];

  console.log(label_file);
  console.log(dest_file);

  try {
    var raw = loadFile(label_file);
    raw = raw.trim();
    var data = raw.split("\n");

    var payload = data.map((e) => {
      var match = e.match(BORICHA_CLASSES_REGEX);

      if (!match) {
        console.log("wrong label!");
        process.exit(1);
      }

      var _id = match[1];
      var _name = match[2];
      return {
        key: e,
        beer_id: _id,
        name: _name,
      };
    });

    var data = {
      BORICHA_CLASSES: payload,
    };

    data = "module.exports = " + JSON.stringify(data, null, 2);

    writeFile(dest_file, data);

    console.log("done");
  } catch (e) {
    console.error(e);
    process.exit(1);
  }
};

const loadFile = (path) => {
  try {
    return fs.readFileSync(path, "utf8");
  } catch (e) {
    console.error("file not found!");
    process.exit(1);
  }
};

const writeFile = (path, payload) => {
  try {
    return fs.writeFileSync(path, payload, "utf8");
  } catch (e) {
    console.error("write file failed!", e);
    process.exit(1);
  }
};

publish(process.argv);
