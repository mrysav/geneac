import { Controller } from '@hotwired/stimulus'
import ajax from '../ajax'
import _ from 'lodash'
import * as d3 from 'd3'
import dTree from '../vendor/dTree/dtree.js'

export default class extends Controller {
  static targets = ['tree']

  connect() {
    const treeRoot = this.treeTarget
    const treeDataUrl = `/p/${treeRoot.dataset.person}/family.json`

    ajax.get({
      endpoint: treeDataUrl,
      callback: (response) => {
        this.renderTree(treeRoot, response)
      },
      parse_json: true,
    })
  }

  renderTree(root, treedata) {
    dTree
      .init(treedata, {
        target: `#${root.id}`,
        width: 800,
        height: 600,
      })
      .zoomToFit()
  }
}
