# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"

pin "bootstrap", to: "https://ga.jspm.io/npm:bootstrap@5.1.3/dist/js/bootstrap.esm.js", preload: true
pin "@popperjs/core", to: "https://ga.jspm.io/npm:@popperjs/core@2.11.2/lib/index.js", preload: true
