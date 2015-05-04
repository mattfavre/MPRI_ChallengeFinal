function [confusionMatrix] = ConfusionMatrix(knownClass, predictedClass)
    [C,order] = confusionmat(knownClass,predictedClass);
    confusionMatrix = C;
end
