/**
 * ConfirmationScreen
 *
 * A reusable confirmation screen for authentication/redirect flows.
 *
 * Props:
 * @param {string} title - Main title of the screen.
 * @param {React.ReactNode} [description] - Optional description below the title.
 * @param {string} [buttonText] - Main action button text.
 * @param {React.ComponentType<{ className?: string }>} [logo] - SVG/Logo component to display at the top.
 * @param {() => void} [onButtonClick] - Callback for the main button click.
 * @param {boolean} loading - If true, disables the button and shows a spinner.
 * @param {React.ComponentType<{ className?: string }>} [logoAction] - Icon to show when loading=true.
 * @param {React.ComponentType<{ className?: string }>} [logoLoading] - Icon to show when loading=false.
 * @param {React.ReactNode} [linkText] - Secondary text/link below the button.
 * @param {React.ReactNode} [children] - Additional elements to render.
 *
 * Accessibility:
 * - The logo container uses aria-label for screen readers.
 * - The button uses aria-busy to indicate loading state.
 */
import { Button } from "@/components/ui/button";
import React from "react";

export interface ConfirmationCardProps {
  /** Main title of the screen */
  title: string;
  /** Optional description below the title */
  description?: React.ReactNode;
  /** Main action button text */
  buttonText?: string;
  /** SVG/Logo component to display at the top */
  logo?: React.ComponentType<{ className?: string }>;
  /** Callback for the main button click */
  onButtonClick?: () => void;
  /** If true, disables the button and shows a spinner */
  loading: boolean;
  /** Icon to show when loading=true */
  logoAction?: React.ComponentType<{ className?: string }>;
  /** Icon to show when loading=false */
  logoLoading?: React.ComponentType<{ className?: string }>;
  /** Secondary text/link below the button */
  linkText?: React.ReactNode;
  /** Additional elements to render */
  children?: React.ReactNode;
}

const ConfirmationCard: React.FC<ConfirmationCardProps> = React.memo(
  ({
    title,
    description,
    buttonText,
    logo: Logo,
    onButtonClick,
    loading,
    logoAction: LogoAction,
    logoLoading: LogoLoading,
    linkText,
    children,
  }) => (
    <div className="flex min-h-screen w-full items-center justify-center p-4 bg-background">
      <div className="flex flex-col items-center text-center space-y-6 w-full max-w-md bg-card text-card-foreground rounded-lg p-8">
        {Logo && (
          <div className="w-8 h-8" aria-label="Logo">
            <Logo className="w-full h-full" />
          </div>
        )}
        <div className="space-y-2 w-full">
          <h1 className="text-2xl font-semibold tracking-tight w-full">
            {title}
          </h1>
          {description && (
            <p className="text-muted-foreground pb-4">{description}</p>
          )}
          {children}
          {linkText && (
            <p className="mt-4 text-sm text-muted-foreground">{linkText}</p>
          )}
        </div>
        {buttonText && (
          <Button
            className="w-full max-w-[200px] bg-[#14161A] hover:bg-[#14161A]/90"
            size="lg"
            onClick={onButtonClick}
            disabled={loading}
            aria-busy={loading}
          >
            {loading
              ? LogoAction && (
                  <LogoAction
                    className="ml-0.5 h-5 w-5 mr-1"
                    aria-hidden="true"
                  />
                )
              : LogoLoading && (
                  <LogoLoading className="ml-0.5 h-5 w-5 animate-spin mr-1" />
                )}
            {buttonText}
          </Button>
        )}
      </div>
    </div>
  )
);

export default ConfirmationCard;
