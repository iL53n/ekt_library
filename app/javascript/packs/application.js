import Vue from 'vue'
import App from '../app'

import iconSet from 'quasar/icon-set/fontawesome-v5.js'
import '@quasar/extras/fontawesome-v5/fontawesome-v5.css'
import '../../assets/styles/quasar.styl'
import 'quasar/dist/quasar.ie.polyfills'
import {
    Quasar,
    QLayout,
    QList,
    QItemSection,
    QItemLabel,
    QItem,
    QHeader,
    QFooter,
    QTab,
    QTabs,
    QRouteTab,
    QTabPanel,
    QTabPanels,
    QDrawer,
    QPageContainer,
    QPage,
    QToolbar,
    QToolbarTitle,
    QBtn,
    QBtnGroup,
    QImg,
    QBadge,
    QBreadcrumbs,
    QBreadcrumbsEl,
    QIcon,
    QPageSticky,
    QPageScroller,
    QAvatar,
    QTable,
    QTh,
    QTr,
    QTd,
    QInput,
    QCard,
    QCardSection,
    QCardActions,
    QForm,
    QSlideTransition,
    QToggle,
    QSpinner,
    QField,
    QDialog,
    QEditor,
    Notify,
    Ripple,
    ClosePopup,
    QSelect
} from 'quasar'

Vue.use(Quasar, {
    config: {},
    components: {
        Quasar,
        QLayout,
        QList,
        QItemSection,
        QItemLabel,
        QItem,
        QHeader,
        QFooter,
        QTab,
        QTabs,
        QRouteTab,
        QTabPanel,
        QTabPanels,
        QDrawer,
        QPageContainer,
        QPage,
        QToolbar,
        QToolbarTitle,
        QBtn,
        QBtnGroup,
        QImg,
        QBadge,
        QBreadcrumbs,
        QBreadcrumbsEl,
        QIcon,
        QPageSticky,
        QPageScroller,
        QAvatar,
        QTable,
        QTh,
        QTr,
        QTd,
        QInput,
        QCard,
        QCardSection,
        QCardActions,
        QForm,
        QSlideTransition,
        QToggle,
        QSpinner,
        QField,
        QDialog,
        QEditor,
        QSelect
    },
    directives: {
        Ripple,
        ClosePopup
    },
    iconSet: iconSet,
    plugins: {
        Notify
    },
});

document.addEventListener('DOMContentLoaded', () => {
    const app = new Vue({
        render: h => h(App),
    }).$mount();
    document.body.appendChild(app.$el)
});