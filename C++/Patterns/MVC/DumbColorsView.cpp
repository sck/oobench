#include "MVC.hpp"
#include "ColorsController.hpp"

namespace oobench {

    class DumbColorsView : public View {
        std::string name;
        unsigned long drawCount;
    public:
        DumbColorsView(Model& theModel, char* theName = "none") 
                : View(theModel), name(theName) {
        }

        DumbColorsView(const DumbColorsView& anotherDumbColorsView) 
                : View(anotherDumbColorsView) {
            name = anotherDumbColorsView.name;
        }

        virtual ~DumbColorsView() {
        }

        Controller* makeController() {
            return new ColorsController(*this);
        }

        ColorsController& getColorsController() const {
            return (ColorsController&)getController();
        }

        virtual void draw() {
            ++drawCount;
        }

         unsigned long getDrawCount() const {
             return drawCount;
         }

    };
}
