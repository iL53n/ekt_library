import Vue from 'vue'
import App from '../app'
import router from '../../router'

import iconSet from 'quasar/icon-set/material-icons'
import '@quasar/extras/material-icons/material-icons.css'
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
    QSelect,
    QMenu,
    QSeparator,
    QBar,
    QSpace,
    QParallax,
    QScrollArea,
    QChip,
    QTooltip
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
        QSelect,
        QMenu,
        QSeparator,
        QBar,
        QSpace,
        QParallax,
        QScrollArea,
        QChip,
        QTooltip
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
        router
    }).$mount();
    document.body.appendChild(app.$el)
});