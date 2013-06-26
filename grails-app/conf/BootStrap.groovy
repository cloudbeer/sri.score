class BootStrap {

    def init = { servletContext ->
        Locale.setDefault(Locale.SIMPLIFIED_CHINESE)
    }
    def destroy = {
    }
}
