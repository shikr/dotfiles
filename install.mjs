#!/usr/bin/env -S npx zx
import util from 'node:util'
const $$ = $({
  sync: true
})
const CONFIG_DIR =
  os.platform() === 'win32'
    ? process.env.LOCALAPPDATA
    : path.join(os.homedir(), '.config')

/**
 * Install option object.
 * @typedef {Object} Option
 * @prop {'string' | 'boolean'} type - The type of the option.
 * @prop {string} [usage] - The usage of the option.
 * @prop {string | string[]} [alias] - The alias of the option.
 * @prop {unknown} [default] - The default value of the option.
 * @prop {string} description - The description of the option.
 */

/**
 * @typedef {Object} Config
 * @prop {string} name - The name of the configuration.
 * @prop {string} configPath - The relative path of the configuration.
 * @prop {string} [targetDir] - The path to install the configuration.
 * @prop {string[]} [dependencies] - List of commands to check for before installing the configuration.
 * @prop {() => unknown} [postInstall] - The function to run after installing the configuration.
 * @prop {() => unknown} [preInstall] - The function to run before installing the configuration.
 * @prop {NodeJS.Platform | NodeJS.Platform[]} [platform] - The platform to install the configuration on.
 */

/**
 * Object representing a repository.
 * @typedef {Object} Repository
 * @prop {string} name - The name of the repository.
 * @prop {string} author - The author of the repository.
 */

/**
 * @type {Record<string, Option>}
 * @description The options for the install script.
 */
const options = {
  ['zsh-plugins']: {
    type: 'boolean',
    alias: 'p',
    description: 'Install zsh plugins.',
    default: true
  },
  symlink: {
    type: 'boolean',
    alias: 'S',
    description: 'Create symlinks instead of copying files.',
    default: true
  },
  backup: {
    type: 'boolean',
    alias: 'b',
    description: 'Backup existing files.',
    default: true
  },
  install: {
    type: 'boolean',
    alias: 'I',
    description:
      'Install all configurations. If disabled, the script will only do a dry run.',
    default: true
  },
  ignore: {
    type: 'string',
    alias: 'i',
    description: 'Ignore configurations. (-i zsh,rofi)',
    usage: '<OPTIONS>'
  },
  silent: {
    type: 'boolean',
    alias: 's',
    description: 'Suppress output.'
  },
  help: {
    type: 'boolean',
    alias: 'h',
    description: 'Show this help message.'
  }
}

const { p: zshPlugins, symlink, backup, i, silent, help, install } = parseArgs()

/**
 * @type {Config[]}
 * @description The list of configurations to install.
 */
const configs = [
  {
    name: 'zsh',
    configPath: '.zshrc',
    targetDir: os.homedir(),
    dependencies: ['zsh'],
    postInstall() {
      if (zshPlugins) {
        const dir = path.join(
          resolveString(
            process.env.ZSH_CUSTOM,
            path.join(
              resolveString(process.env.ZSH, path.join(os.homedir(), '.oh-my-zsh')),
              'custom'
            )
          ),
          'plugins'
        )
        fs.mkdirSync(dir, { recursive: true })
        /**
         * @type {Repository[]}
         * @description The list of repositories to clone.
         */
        const repositories = [
          { author: 'grigorii-zander', name: 'zsh-npm-scripts-autocomplete' },
          { author: 'MenkeTechnologies', name: 'zsh-cargo-completion' },
          { author: 'zsh-users', name: 'zsh-syntax-highlighting' },
          { author: 'zsh-users', name: 'zsh-autosuggestions' },
          { author: 'zsh-users', name: 'zsh-completions' },
          { author: 'hlissner', name: 'zsh-autopair' },
          { author: 'redxtech', name: 'zsh-kitty' },
          { author: 'zshzoo', name: 'cd-ls' }
        ]

        repositories.forEach(({ author, name }) => {
          const repoPath = path.join(dir, name)
          if (!fs.existsSync(repoPath)) {
            info('Cloning %s plugin...', name)
            $$`git clone https://github.com/${author}/${name}.git ${repoPath}`
          } else {
            info('Updating %s plugin...', name)
            $$`git -C ${repoPath} pull`
          }
        })
      }
    }
  },
  {
    name: 'kitty',
    configPath: 'kitty',
    dependencies: ['kitty'],
    platform: ['linux', 'darwin']
  },
  {
    name: 'rofi',
    configPath: 'rofi',
    dependencies: ['rofi'],
    platform: 'linux'
  },
  {
    name: 'spotify_player',
    configPath: 'spotify-player',
    dependencies: ['spotify_player']
  },
  {
    name: 'nvim',
    configPath: 'nvim',
    dependencies: ['nvim', 'node', 'git', 'ripgrep', 'yarn']
  },
  {
    name: 'starship',
    configPath: 'starship.toml',
    targetDir: path.join(os.homedir(), '.config'),
    dependencies: ['starship']
  }
]
/**
 * @type {string[]}
 * @description The list of ignored files or directories.
 */
const ignore = i ? i.split(',') : []

if (help) {
  showHelp()
  process.exit(0)
}

await Promise.all(
  configs
    .filter(({ name }) => !ignore.includes(name))
    .map((config) => installConfig(config))
)

/**
 * Parses the command line arguments.
 * @returns {import('minimist').ParsedArgs}
 */
function parseArgs() {
  const filename = fs.realpathSync(process.argv[2])

  return minimist(
    process.argv.slice(filename === __filename ? 3 : 2),
    Object.entries(options).reduce(
      (acc, [key, { type, alias, default: _default }]) => ({
        ...acc,
        [type]: [...acc[type], key],
        alias: { ...acc.alias, [key]: alias },
        default: {
          ...acc.default,
          [key]: _default
        }
      }),
      {
        boolean: [],
        string: [],
        alias: {},
        default: {}
      }
    )
  )
}

/**
 * Installs the given configuration.
 * @param {Config} config The configuration to install.
 */
async function installConfig(config) {
  if (
    config.platform &&
    (Array.isArray(config.platform)
      ? !config.platform.includes(process.platform)
      : config.platform !== process.platform)
  )
    return error(
      '%s is not supported on %s. Skipping installation.',
      config.name,
      process.platform
    )

  spinner(chalk.blue(`Installing ${config.name}...`), async () => {
    if (config.dependencies) {
      for (const dependency of config.dependencies) {
        if (!commandExists(dependency)) {
          warn('%s is not installed.', dependency)
        }
      }
    }

    if (config.preInstall) {
      await config.preInstall()
    }

    if (install) {
      const { configPath, targetDir } = config
      const realpath = fs.realpathSync(configPath)
      const installPath = targetDir ?? CONFIG_DIR
      const destination = path.join(installPath, path.parse(configPath).base)

      if (fs.existsSync(destination)) {
        if (backup) {
          let backupNum = 1
          while (fs.existsSync(`${destination}${'.bak'.repeat(backupNum)}`)) {
            backupNum++
          }
          fs.renameSync(destination, `${destination}${'.bak'.repeat(backupNum)}`)
        } else {
          error('%s already exists. Backup is disabled.', destination)
          const answer = await confirmation('Do you want to overwrite it?', false)
          if (answer) {
            fs.rmSync(destination, { recursive: true, force: true })
          } else return
        }
      }

      if (symlink) {
        fs.symlinkSync(realpath, destination)
      } else {
        fs.cpSync(realpath, destination, { recursive: true })
      }
    }

    if (config.postInstall) {
      await config.postInstall()
    }
  })
}

/**
 * Asks the user a question and returns the answer.
 * @param {string} query The question to ask.
 * @param {boolean} [defaultValue=true] The default value to return if the user doesn't answer.
 * @returns {Promise<boolean>} The answer from the user.
 */
async function confirmation(query, defaultValue = true) {
  const answer = await question(query + ` (${defaultValue ? 'Y/n' : 'y/N'}) `)
  const reg = new RegExp(`^${defaultValue ? 'no?' : 'y(es)?'}$`, 'i')
  return defaultValue ? !reg.test(answer) : reg.test(answer)
}

/**
 * Shows the help message.
 */
function showHelp() {
  const opts = Object.entries(options)
  const maxKeyLength = Math.max(
    ...opts.map(([key, option]) => formatOption(key, option).length)
  )
  /**
   * Prints the option to the console.
   * @param {string} key The key of the option.
   * @param {Option} option The option object.
   */
  const printOption = (key, option) => {
    const optStr = formatOption(key, option)
    const padding = ' '.repeat(maxKeyLength - optStr.length)
    const defaultStr =
      options[key].default !== undefined
        ? chalk.gray(`(default: ${options[key].default})`)
        : ''
    console.log(`  ${optStr}${padding} ${option.description} ${defaultStr}`)
  }

  console.log(chalk.green('Usage:'), './install.mjs [...OPTIONS]\n')
  console.log(chalk.green('Options:'))
  opts.slice(0, -2).forEach(([key, option]) => printOption(key, option))
  console.log(
    ' '.repeat(maxKeyLength + 2),
    'OPTIONS:',
    configs.map((c) => c.name).join(', '),
    '\n'
  )
  opts.slice(-2).forEach(([key, option]) => printOption(key, option))
}

/**
 * Formats the option string.
 * @param {string} name The name of the option.
 * @param {Option} option The option to format.
 * @returns {string} The formatted option string.
 */
function formatOption(name, option) {
  /**
   * Format a single option to a string.
   * @param {string} o The string to format.
   * @returns {string} The formatted string.
   */
  const singleOption = (o) => (o.length > 1 ? `--${o}` : `-${o}`)
  const alias = Array.isArray(option.alias)
    ? option.alias.map(singleOption).join(', ')
    : singleOption(option.alias)
  return (
    (alias.length > 0 ? `${alias}, ` : '') +
    singleOption(name) +
    (option.usage ? ` ${option.usage}` : '')
  )
}

/**
 * Prints a message to the console.
 * @param  {...any} args Default arguments to console.log.
 */
function info(...args) {
  if (!silent) {
    console.log(`${chalk.blue(printable(args[0]))}`, ...args.slice(1))
  }
}

/**
 * Prints a warning message to the console.
 * @param  {...any} args Default arguments to console.warn.
 */
function warn(...args) {
  console.warn(`${chalk.yellow('Warning:')} ${printable(args[0])}`, ...args.slice(1))
}

/**
 * Prints a error message to the console.
 * @param  {...any} args Default arguments to console.error.
 */
function error(...args) {
  console.error(`${chalk.red('Error:')} ${printable(args[0])}`, ...args.slice(1))
}

/**
 * Formats data for printing.
 * @param {any} data The data to format.
 * @returns {string} The inspected data.
 */
function printable(data) {
  return typeof data === 'string'
    ? data
    : util.inspect(data, { showHidden: true, showProxy: true })
}

/**
 * Resolves a string to a fallback value.
 * @param {string | undefined} str A string to resolve.
 * @param {string} fallback A fallback string to return if str is undefined.
 * @returns {string} The resolved string.
 */
function resolveString(str, fallback) {
  if (str === undefined) {
    return fallback
  }
  return str
}

/**
 * Checks if a command exists in the system.
 * @param {string} command The command to check.
 * @returns {boolean} True if the command exists, false otherwise.
 */
function commandExists(command) {
  return which.sync(command, { nothrow: true }) !== null
}
